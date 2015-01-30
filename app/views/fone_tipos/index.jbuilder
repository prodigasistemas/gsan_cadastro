json.fone_tipos do
  json.array! @tipos do |tipo|
    json.partial! tipo
  end
end
