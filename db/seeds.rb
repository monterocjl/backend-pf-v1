Operation.destroy_all
OperationCategory.destroy_all
Table.destroy_all
User.destroy_all

# users
juan = User.create(email: 'jmonteroc.91@gmail.com', password: '123456', name: 'Juan Luis', lastname: 'Montero', avatar_url: "https://res.cloudinary.com/gscloudinary/image/upload/c_scale,w_128/v1679340900/conta-fam/public/jl_mb8cas.jpg")
claudia = User.create(email: 'Claudia.monteroc90@gmail.com', password: '123456', name: 'Claudia', lastname: 'Montero', avatar_url: "https://res.cloudinary.com/gscloudinary/image/upload/c_scale,w_158/v1679340900/conta-fam/public/clau_yyetiu.jpg")
luz = User.create(email: 'luzccruz0611@gmail.com', password: '123456', name: 'Lucha', lastname: 'Cruz', avatar_url: "https://res.cloudinary.com/gscloudinary/image/upload/c_scale,w_160/v1679340901/conta-fam/public/lucha_sz7vjo.jpg")
evaristo = User.create(email: 'monterosanchezjuan@gmail.com', password: '123456', name: 'Juan', lastname: 'Montero', avatar_url: "https://res.cloudinary.com/gscloudinary/image/upload/c_scale,w_144/v1679340900/conta-fam/public/juanito_nfksye.jpg")

# tables
familyTable = Table.create(name: "Familia", description: "", users_access: [claudia.id, luz.id, evaristo.id], user: juan )
chiflesTable = Table.create(name: "Chifles", description: "", users_access: [claudia.id, luz.id, evaristo.id], user: juan )

# operations categories
family_incomeOperations = ["Efectivo", "Depósito"]
family_outcomeOperations = ["Bodega", "Casa", "Farmacia", "Carro", "Salud", "Gas", "Internet", "Celular", "Mantenimiento", "Luz", "Cochera", "Otros"]
chifles_incomeOperations = ["Trabajo Lucha", "SENASA", "Iris", "Condominio", "Familiares", "Otros"]
chifles_outcomeOperations = ["Recojo de chifles", "Compra a Keylita", "Materiales", "Otros"]

family_incomeOperations.each { |operation| OperationCategory.create(name: operation, description: "", operation_type: 0 , table: familyTable)}
family_outcomeOperations.each { |operation| OperationCategory.create(name: operation, description: "", operation_type: 1 , table: familyTable)}
chifles_incomeOperations.each { |operation| OperationCategory.create(name: operation, description: "", operation_type: 0 , table: chiflesTable)}
chifles_outcomeOperations.each { |operation| OperationCategory.create(name: operation, description: "", operation_type: 1 , table: chiflesTable)}

# # operations
require 'csv'
familyTableCSV = File.read(Rails.root.join('family-table-2.csv'))
parse_familyTableCSV = CSV.parse(familyTableCSV, :headers => true, :encoding => 'utf-8')

parse_familyTableCSV.each do |operation|
  ope_hash =  operation.to_hash

  @user
  if ope_hash["\uFEFFUsuario"] == "Luchita"
    @user = luz
  elsif ope_hash["\uFEFFUsuario"] == "Juanito"
    @user = evaristo
  elsif ope_hash["\uFEFFUsuario"] == "Claudia"
    @user = claudia
  elsif ope_hash["\uFEFFUsuario"] == "Juan Luis"
    @user = juan
  end

  @operation_type
  if ope_hash["Operacion"] == "Gasto"
    @operation_type = 1
  elsif ope_hash["Operacion"] == "Ingreso"
    @operation_type = 0
  end

  @operation_type
  @table_filtered
  if ope_hash["Operacion"] == "Gasto"
    @operation_type = 1
    @table_filtered = familyTable.operation_categories.all.where("operation_type = 1")
  elsif ope_hash["Operacion"] == "Ingreso"
    @operation_type = 0 
    @table_filtered = familyTable.operation_categories.all.where("operation_type = 0")
  end

  category = @table_filtered.find_by(name: ope_hash["Categoria"])

  Operation.create(import: ope_hash["Importe"].to_f, description: ope_hash["Descripcion"], attached_url: ope_hash["Adjunto"], operation_date: ope_hash["Fecha_operacion"], operation_category: category, table: familyTable, user: @user)
end

chiflesTableCSV = File.read(Rails.root.join('chifles-table-2.csv'))
parse_chiflesTableCSV = CSV.parse(chiflesTableCSV, :headers => true, :encoding => 'utf-8')

parse_chiflesTableCSV.each do |operation|
  ope_hash =  operation.to_hash

  @user
  if ope_hash["\uFEFFUsuario"] == "Luchita"
    @user = luz
  elsif ope_hash["\uFEFFUsuario"] == "Juanito"
    @user = evaristo
  elsif ope_hash["\uFEFFUsuario"] == "Claudia"
    @user = claudia
  elsif ope_hash["\uFEFFUsuario"] == "Juan Luis"
    @user = juan
  end

  @operation_type
  @table_filtered
  if ope_hash["Operacion"] == "Gasto"
    @operation_type = 1
    @table_filtered = chiflesTable.operation_categories.all.where("operation_type = 1")
  elsif ope_hash["Operacion"] == "Ingreso"
    @operation_type = 0 
    @table_filtered = chiflesTable.operation_categories.all.where("operation_type = 0")
  end

  category = @table_filtered.find_by(name: ope_hash["Categoria"])
  importe = ope_hash["Importe"].to_f

  Operation.create(import: importe, description: ope_hash["Descripcion"], attached_url: ope_hash["Adjunto"], operation_date: ope_hash["Fecha_operacion"], operation_category: category, table: chiflesTable, user: @user) 
end