#!/bin/bash
### BEGIN INIT INFO
#### BASED ON THE GIST: https://gist.github.com/2623205
# Provides: unicorn
# Required-Start: $all
# Required-Stop: $network $local_fs $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Start the unicorns at boot
# Description: Enable at boot time.
### END INIT INFO

# Save this file to /etc/init.d/<application_name>, and run:
# /etc/init.d/<application_name> start|stop|restart
#
# Configure your app by replacing everything within `{{ }}`, or use this as a SaltStack template.
#
# The restart command waits to ensure that the old unicorn master is replaced by the new one.
# If the restart times out (after 120 seconds), then the script returns an exit code of 1.
# This means that you can use this script during a Capistrano deploy, and be confident
# that your unicorn processes are being properly restarted.

export RVM_SCRIPT="/usr/local/rvm/scripts/rvm"
export APP_USER="jenkins"
export RAILS_ENV="production"
export APP_ROOT="/var/www/gsan-api/current"
export PID_PATH="/tmp"
export UNICORN_CONFIG_FILE="$APP_ROOT/config/unicorn.rb"
export UNICORN_BIN="unicorn_rails"

BUNDLE_PATH=$(which bundle)
export UNICORN_CMD="${BUNDLE_PATH} exec ${UNICORN_BIN} -E ${RAILS_ENV} -c \"${UNICORN_CONFIG_FILE}\" -D"

export PID_FILE="$PID_PATH/.unicorn.gsan-api.pid"
export OLD_PID_FILE="$PID_FILE.oldbin"
export RUBY_VERSION_FILE="$PID_PATH/unicorn.ruby-version"

# If the init script is run by the root user, we need to run it as the APP_USER
if [[ $EUID -eq 0 ]]; then
  export UNICORN_CMD="sudo -u ${APP_USER} /bin/bash -c \"${UNICORN_CMD}\""
fi

# Check that Rails directory exists
cd $APP_ROOT || return 1


sig () {
  [ -s "$PID_FILE" ] && kill -$1 `cat "$PID_FILE"`
}

workersig () {
  local workerpid="$PID_PATH/unicorn.worker.$2.pid"
  [ -s "$workerpid" ] && kill -$1 `cat $workerpid`
}

cmd () {
  case $1 in
    start)
      if [ -s "$PID_FILE" ]; then
        echo >&2 "Already running"
        return 0
      fi

      echo "Starting unicorn..."

      source "${RVM_SCRIPT}"
      eval $UNICORN_CMD
      # Store the current ruby version. If this changes, we need to do a cold restart.
      echo "$RUBY_VERSION" > "$RUBY_VERSION_FILE"
      chown "$APP_USER:$APP_USER" "$RUBY_VERSION_FILE"
      ;;

    stop)
      sig QUIT && echo "Stopping" && rm -f "$RUBY_VERSION_FILE" && return 0
      echo >&2 "Not running"
      ;;

    force-stop)
      sig TERM && echo "Forcing a stop" && rm -f "$RUBY_VERSION_FILE" && return 0
      echo >&2 "Not running"
      ;;

    restart|reload)
      # Based on http://www.rostamizadeh.net/blog/2012/03/09/wrangling-unicorn-usr2-signals-and-capistrano-deployments/
      TIMEOUT=120 # two minutes to restart

      if [ -s "$PID_FILE" ]; then
        ORIG_PID=`cat $PID_FILE`
      else
        echo >&2 "Unicorn is not running."
        $0 start
        return 0
      fi

      # Source RVM and set correct Ruby version
      source "${RVM_SCRIPT}"

      echo "Original PID: $ORIG_PID"

      if [ -e "$RUBY_VERSION_FILE" ]; then
        OLD_RUBY_VERSION="$(cat "$RUBY_VERSION_FILE")"

        if [ "$OLD_RUBY_VERSION" != "$RUBY_VERSION" ]; then
          echo >&2 "Ruby version has changed from $OLD_RUBY_VERSION to $RUBY_VERSION."
          echo >&2 "Performing a cold restart..."
          $0 stop

          n=$TIMEOUT
          echo 'Waiting for unicorn master to stop...'
          while [ -s "$PID_FILE" ] && [ "$n" -ge 0 ]
          do
            sleep 1 && n=$(( $n - 1 ))
          done

          if [ -s "$PID_FILE" ]; then
            echo 'Unicorn master failed to stop!'
            exit 1
          fi

          $0 start
          return 0
        fi
      fi

      if sig USR2; then
        echo 'USR2 sent; Waiting for .oldbin'
        n=$TIMEOUT

        # wait for .oldpid to be written
        while (!([ -s "$OLD_PID_FILE" ]) && [ "$n" -ge 0 ])
        do
          sleep 1 && n=$(( $n - 1 ))
        done

        echo 'Waiting for new pid file'
        # When this loop finishes, should have new pid file
        while (!([ -s "$PID_FILE" ]) || [ -s "$OLD_PID_FILE" ]) && [ "$n" -ge 0 ]; do
          sleep 1 && n=$(( $n - 1 ))
        done

        if [ -s "$PID_FILE" ]; then
          NEW_PID=`cat $PID_FILE`
        else
          echo 'New master failed to start; see error log'
          exit 1
        fi

        # Timeout has elapsed, verify new pid file exists
        if [ "$ORIG_PID" -eq "$NEW_PID" ]; then
          echo
          echo >&2 'New master failed to start; see error log'
          exit 1
        fi

        echo "New PID: $NEW_PID"

        # Verify old master QUIT
        echo
        if [ -e "$OLD_PID_FILE" ]; then
          echo >&2 "$OLD_PID_FILE still exists after $TIMEOUT seconds. Sending TERM."
          kill `cat "$OLD_PID_FILE"`
        fi

        echo 'Unicorn successfully upgraded'
        exit 0
      fi

      echo >&2 "Upgrade failed: executing '$UNICORN_CMD' "
      eval "$UNICORN_CMD"
      ;;


    kill_worker)
      workersig QUIT $2 && exit 0
      echo >&2 "Worker not running"
      ;;

    rotate)
      sig USR1 && echo rotated logs OK && return 0
      echo >&2 "Couldn't rotate logs" && return 1
      ;;

    *)
      echo >&2 "Usage: $0 <start|stop|kill_worker|upgrade|restart|rotate|force-stop>"
      exit 1
      ;;
  esac
}

if [ $? -eq 1 ]; then
  exit
fi

cmd $*