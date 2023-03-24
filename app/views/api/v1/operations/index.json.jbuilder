json.data do
  json.table do
    json.id @table.id
    json.name @table.name
    json.user_id @table.user_id
    json.description @table.description
    json.categories @categories
  end
  json.operations @operations
end