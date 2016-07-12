# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bi_logradouro", id: false, force: :cascade do |t|
    t.integer  "logr_id",                                             null: false
    t.string   "logr_nmlogradouro",      limit: 40,                   null: false
    t.integer  "lgtt_id"
    t.integer  "lgtp_id",                                             null: false
    t.integer  "muni_id",                                             null: false
    t.integer  "logr_icuso",             limit: 2
    t.datetime "logr_tmultimaalteracao",            default: "now()", null: false
    t.string   "logr_nmpopular",         limit: 30
  end

  create_table "changelog", force: :cascade do |t|
    t.string "applied_at",  limit: 25,  null: false
    t.string "description", limit: 255, null: false
  end

  create_table "cliente_endereco_max_cled_id", id: false, force: :cascade do |t|
    t.integer "clie_id"
    t.integer "lgbr_id"
    t.integer "lgcp_id"
    t.integer "cled_id"
  end

  create_table "conta_sicom_aberta", id: false, force: :cascade do |t|
    t.integer "matricula_cliente_imovel"
    t.integer "data_referencia"
    t.decimal "num_fatura"
    t.integer "matricula_cliente_centralizador"
    t.integer "data_emissao_fatura"
    t.integer "cnta_id"
  end

  create_table "ligacaounidadeoperacional", id: false, force: :cascade do |t|
    t.string "source_id",   limit: 255, null: false
    t.string "target_id",   limit: 255, null: false
    t.string "source_name", limit: 255
    t.string "target_name", limit: 255
  end

  create_table "logr", primary_key: "logr_id", force: :cascade do |t|
    t.string "logr_nmlogradouro", limit: 50
  end

  create_table "nodesigma", force: :cascade do |t|
    t.string "label", limit: 255
    t.string "type",  limit: 255
  end

  create_table "pagamentos_cosanpa", id: false, force: :cascade do |t|
    t.integer "cnta_id"
    t.integer "pgmt_amreferenciapagamento",                          null: false
    t.decimal "pgmt_vlpagamento",           precision: 13, scale: 2
    t.date    "pgmt_dtpagamento"
    t.integer "imov_id",                                             null: false
    t.decimal "cnta_vlconta",               precision: 13, scale: 2
    t.decimal "cnhi_vlconta",               precision: 13, scale: 2
  end

  create_table "rgat", primary_key: "rgat_id", force: :cascade do |t|
    t.string "rgat_nmrgatadouro", limit: 500
  end

end
