# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090511194934) do

  create_table "estados", :force => true do |t|
    t.string   "nome"
    t.string   "sigla"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foranias", :force => true do |t|
    t.integer  "vicariato_id"
    t.integer  "numero"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "missionarios", :force => true do |t|
    t.string   "nome"
    t.date     "nascimento"
    t.string   "endereco"
    t.string   "bairro"
    t.string   "cidade"
    t.integer  "estado_id"
    t.string   "cep"
    t.string   "email"
    t.string   "estado_civil"
    t.string   "profissao"
    t.text     "movimentos_pastorais"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "paroquia_id"
  end

  create_table "missionarios_sacramentos", :id => false, :force => true do |t|
    t.integer  "missionario_id"
    t.integer  "sacramento_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paroquias", :force => true do |t|
    t.string   "nome"
    t.integer  "forania_id"
    t.string   "bairro"
    t.integer  "num_de_comunidades"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sacramentos", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "telefones", :force => true do |t|
    t.string   "tipo_telefone"
    t.integer  "ddd"
    t.integer  "numero"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vicariatos", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
