# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_06_10_184013) do

  create_table "abonos_promesas", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.string "NoPago", limit: 45
    t.decimal "AbonoPromesa", precision: 12, scale: 2
    t.date "Vencimiento"
    t.integer "IDSolicitud", unsigned: true
  end

  create_table "abonospagare", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "utf8", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "IDPagare", default: 0
    t.decimal "Importe", precision: 14, scale: 2, default: "0.0"
    t.datetime "Fecha", default: "1900-01-01 00:00:00"
    t.integer "ConceptoAbono", default: 0, comment: "Capital intereses morosos", unsigned: true
    t.integer "TipoAbono", default: 0, unsigned: true
    t.integer "IDUsuario", default: 0, unsigned: true
    t.boolean "Cancelado", default: false
    t.datetime "FechaCancelado", default: "1900-01-01 00:00:00"
    t.integer "IDUsuarioCancelado", default: 0, unsigned: true
    t.boolean "Bonificado", default: false, comment: "1=Pago Bonificado"
    t.integer "FolioTicket", default: 0, unsigned: true
    t.integer "FormaPago", default: 0, unsigned: true
    t.decimal "SaldoAnterior", precision: 15, scale: 2, default: "0.0"
    t.decimal "SaldoActual", precision: 15, scale: 2, default: "0.0"
    t.string "ProximoPago", limit: 75
    t.string "PagoRealizadoPor", limit: 45, default: ""
    t.integer "IDPagoRealizado", unsigned: true
    t.text "Observaciones"
    t.string "TipoPago", limit: 45
    t.datetime "FechaAplicado", default: "1900-01-01 00:00:00"
    t.string "FolioFactura", limit: 45, default: ""
    t.integer "IDOrigen", default: 0, unsigned: true
    t.integer "FolioMasivo", default: 0, unsigned: true
    t.integer "IDOficialCobro", default: 0, unsigned: true
    t.index ["Cancelado"], name: "Ix_cancelado"
  end

  create_table "active_storage_attachments", charset: "latin1", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.integer "position", default: 0
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "latin1", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: 6, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "latin1", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "actividad_vulnerable", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.text "Descripcion"
    t.string "Clave", limit: 25
    t.decimal "Vsm", precision: 10, scale: 2, default: "0.0"
    t.boolean "Status", default: false
  end

  create_table "agente_promotor", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "latin1", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "IDAgente", default: 0, null: false, unsigned: true
    t.integer "IDPromotor", default: 0, null: false, unsigned: true
    t.datetime "Fecha", default: "1900-01-01 00:00:00", null: false
    t.datetime "FechaBaja", default: "1900-01-01 00:00:00", null: false
    t.boolean "Activo", default: true
    t.integer "IDUsuario", default: 0, null: false, unsigned: true
    t.integer "IDUsuarioBaja", default: 0, null: false, unsigned: true
  end

  create_table "agentes", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "Codigo", limit: 60
    t.string "Nombre", limit: 120
    t.string "Domicilio", limit: 120
    t.string "Telefono", limit: 20
    t.string "Celular", limit: 20
    t.boolean "Activo"
    t.string "Tipo", limit: 20
  end

  create_table "ant_actividad_economica", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "Clave", limit: 25
    t.text "Nombre_actividad_economica"
    t.text "Rama"
    t.text "Subrama"
  end

  create_table "ant_giro_mercantil", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "Clave", limit: 25
    t.text "Nombre_giro"
    t.text "Rama"
    t.text "Subrama"
  end

  create_table "ant_inmueble_blindado", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.text "Descripcion"
    t.string "Clave", limit: 25
  end

  create_table "ant_instrumento_monetario", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.text "Descripcion"
    t.string "Clave", limit: 25
  end

  create_table "ant_paises", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.text "Descripcion"
    t.string "Clave", limit: 25
  end

  create_table "ant_prioridades", primary_key: "Id", id: { type: :integer, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.string "Clave", limit: 60
    t.string "Descripcion", limit: 105
  end

  create_table "ant_tipo_alerta", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.text "Descripcion"
    t.string "Clave", limit: 25
    t.integer "Id_actividad_vulnerable"
  end

  create_table "ant_tipo_garantia", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.text "Descripcion"
    t.string "Clave", limit: 25
  end

  create_table "ant_tipo_identificacion", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.text "Descripcion"
    t.string "Clave", limit: 25
    t.string "Dependencia", limit: 105
  end

  create_table "ant_tipo_inmueble", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.text "Descripcion"
    t.string "Clave", limit: 25
  end

  create_table "ant_tipo_moneda", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "Clave", limit: 25
    t.text "Moneda"
    t.text "Pais"
  end

  create_table "ant_tipo_operacion", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.text "Descripcion"
    t.string "Clave", limit: 15
    t.integer "Id_actividad_vulnerable"
  end

  create_table "antilavado_parametros", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "utf8", force: :cascade do |t|
    t.string "RFC", limit: 15
    t.string "Nombre", limit: 80
    t.integer "IdActividadVulnerable", default: 0, unsigned: true
    t.integer "IdMoneda", default: 0, unsigned: true
    t.decimal "VSMD", precision: 14, scale: 2, default: "0.0"
    t.decimal "NSM", precision: 14, default: "0", comment: "Numero de veces salarios minimos para reportar"
    t.string "CodigoPostal", limit: 5, default: "0"
    t.string "Constancia", limit: 45
  end

  create_table "auxiliar", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.datetime "Fecha"
    t.time "Hora"
    t.integer "Movimiento", default: 0
    t.string "Concepto", limit: 200
    t.string "Iniciales", limit: 20
    t.integer "Folio", default: 0, unsigned: true
    t.string "Cuenta", limit: 15
    t.decimal "Cargo", precision: 14, scale: 4, default: "0.0"
    t.decimal "Abono", precision: 14, scale: 4, default: "0.0"
    t.string "PC", limit: 25
    t.integer "IDUsuario", default: 0
    t.integer "Corte", default: 0, unsigned: true
    t.integer "TipoMovimiento", default: 0
    t.integer "IDPagare", default: 0
    t.boolean "Parcial", default: false, unsigned: true
    t.string "FormaPago", limit: 45
    t.index ["Fecha"], name: "Fecha"
  end

  create_table "aval", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDSolicitud"
    t.string "Apellidos", limit: 60
    t.string "Nombre", limit: 150
    t.string "Direccion", limit: 180
    t.string "Colonia", limit: 150
    t.string "Municipio", limit: 150
    t.string "Ciudad", limit: 150
    t.string "Estado", limit: 150
    t.string "Telefono", limit: 20
    t.string "TelTrabajo", limit: 20
    t.string "Parentesco", limit: 50
    t.integer "IDGrupo", default: 0
    t.integer "IDClienteAval", default: 0, unsigned: true
    t.boolean "ConoceAlAval", default: false
    t.boolean "NoTieneCreditos", default: false
    t.index ["IDSolicitud"], name: "fk_Aval_SolicitudCredito"
  end

  create_table "bancos", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "Codigo", limit: 60
    t.string "Banco", limit: 30
    t.string "Sucursal", limit: 30
    t.string "Cuenta", limit: 20
    t.string "CLABE", limit: 20
    t.string "CuentaContable", limit: 30
    t.string "Direccion", limit: 60
    t.string "Colonia", limit: 20
    t.string "Ciudad", limit: 25
    t.string "Estado", limit: 20
    t.string "CodigoPostal", limit: 10
    t.integer "Moneda", limit: 1
    t.string "Ejecutivo", limit: 80
    t.string "Cargo", limit: 40
    t.string "Telefono", limit: 20
    t.string "Extension", limit: 10
    t.string "Fax", limit: 20
    t.index ["ID"], name: "fk_Bancos_OtrosMovimientos1"
    t.index ["ID"], name: "fk_Bancos_ProductosGastosFinancieros1"
  end

  create_table "bitacora", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDUsuario", default: 0
    t.date "Fecha"
    t.time "Hora"
    t.string "Tabla", limit: 120
    t.text "Observaciones"
    t.text "Descripcion"
    t.index ["IDUsuario"], name: "fk_Bitacora_Usuarios"
  end

  create_table "boveda", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.datetime "Fecha"
    t.integer "Folio", default: 0
    t.boolean "Cancelado", default: false
    t.datetime "FechaMovimiento"
    t.boolean "Deposito", default: false
    t.string "Concepto", limit: 80
    t.decimal "Importe", precision: 14, scale: 4, default: "0.0"
    t.integer "IDUsuario", default: 0
  end

  create_table "catalogo_documentos", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.string "Nombre", limit: 45, null: false
    t.integer "Activo", default: 1, null: false, unsigned: true
    t.string "TipoProceso", limit: 75
  end

  create_table "claves", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.string "ClavePorAutorizar", limit: 45
    t.string "ClaveAutorizo", limit: 45
    t.integer "IDUsuarioGenera", unsigned: true
    t.integer "IDUsuarioAutorizo", unsigned: true
    t.datetime "Fecha", default: "1900-01-01 00:00:00"
    t.integer "Activo", unsigned: true
    t.string "Tipo", limit: 45
  end

  create_table "clientes", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "NumeroCliente", limit: 10, null: false
    t.string "NumeroCuenta", limit: 10
    t.string "ApellidoPaterno", limit: 80
    t.string "ApellidoMaterno", limit: 80
    t.string "Nombre", limit: 80
    t.string "Direccion", limit: 100
    t.string "Colonia", limit: 60
    t.string "CodigoPostal", limit: 10
    t.string "Localidad", limit: 60
    t.string "Ciudad", limit: 60
    t.string "Estado", limit: 50
    t.string "RFC", limit: 20
    t.string "CURP", limit: 25
    t.string "FolioIFE", limit: 25
    t.string "EntreCalles", limit: 160
    t.date "FechaNacimiento"
    t.string "LugarNacimiento", limit: 70
    t.integer "IDEstadoCivil"
    t.integer "Nacionalidad", default: 0, unsigned: true
    t.integer "Sexo", limit: 1
    t.string "TelefonoCasa", limit: 20
    t.string "Celular", limit: 20
    t.string "Email", limit: 60
    t.integer "Regimen"
    t.integer "TipoPersona"
    t.integer "TipoEmpresa"
    t.string "Detalle", limit: 80
    t.string "Empresa", limit: 200
    t.string "RazonSocial", limit: 80
    t.string "DireccionEmpresa", limit: 100
    t.string "ColoniaEmpresa", limit: 60
    t.string "CodigoPostalEmpresa", limit: 10
    t.string "LocalidadEmpresa", limit: 60
    t.string "CiudadEmpresa", limit: 60
    t.string "EstadoEmpresa", limit: 50
    t.string "Puesto", limit: 50
    t.integer "Antiguedad"
    t.string "TelefonoEmpresa", limit: 20
    t.string "Extension", limit: 6
    t.string "Sector", limit: 60
    t.integer "Status", default: 0
    t.integer "Moroso", default: 0, null: false
    t.integer "Buro", default: 0, null: false
    t.string "NumeroInterior", limit: 45
    t.string "NumeroExterior", limit: 45
    t.integer "IdTipoIdentificacion", default: 0, unsigned: true
    t.integer "IdActividadEconomica", default: 0, unsigned: true
    t.string "MoralRazonSocial", limit: 60
    t.datetime "MoralFechaAlta", default: "1900-01-01 00:00:00"
    t.string "MoralRFC", limit: 13
    t.integer "MoralIdGiroMercantil", default: 0, unsigned: true
    t.integer "MoralIdPaisNacionalidad", default: 0, unsigned: true
    t.boolean "TipoPersonaCliente", default: false
    t.decimal "LimiteCredito", precision: 12, scale: 2, default: "0.0"
    t.string "RegimenSocial", limit: 45
    t.string "NombreEmpresaPropia", limit: 105
    t.string "Profesion", limit: 105
    t.integer "IDUsuarioBaja", unsigned: true
    t.string "MotivoBaja", limit: 155
    t.index ["IDEstadoCivil"], name: "fk_Clientes_EstadoCivil"
    t.index ["NumeroCliente"], name: "NumeroCliente"
    t.index ["NumeroCuenta"], name: "NumeroCuenta"
  end

  create_table "clientes_documentos", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.integer "IDCatalagoDocumento", unsigned: true
    t.string "RutaLocal", limit: 250
    t.string "Nombre"
    t.string "Extension", limit: 45
    t.integer "UsuarioID", unsigned: true
    t.integer "Activo", unsigned: true
  end

  create_table "colonias", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.string "Descripcion", limit: 105
    t.integer "IDMunicipio", unsigned: true
  end

  create_table "comentarios", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.text "Comentario", null: false
    t.datetime "Fecha", null: false
    t.integer "IDUsuario", null: false, unsigned: true
    t.integer "IDRegistro", null: false, unsigned: true
    t.string "Tabla", limit: 85, null: false
    t.string "Status", limit: 15, default: "Activo"
    t.datetime "FechaBaja"
    t.integer "IDUsuarioBaja", default: 0, unsigned: true
  end

  create_table "conceptos", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "Concepto", limit: 60
    t.string "CuentaContable", limit: 30
    t.index ["ID"], name: "fk_Conceptos_OtrosMovimientos1"
  end

  create_table "condicionesvivienda", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDDiagnostico"
    t.string "TiempoDomicilio", limit: 45
    t.integer "TipoVivienda", limit: 1
    t.string "Especificar", limit: 45
    t.string "Piso", limit: 45
    t.string "Muros", limit: 45
    t.string "Techo", limit: 45
    t.string "Bano", limit: 45
    t.string "Cocina", limit: 45
    t.integer "Recamaras", limit: 1
    t.integer "Niveles", limit: 1
    t.boolean "Luz"
    t.boolean "AguaPotable"
    t.boolean "Drenaje"
    t.boolean "Telefono"
    t.boolean "TVCable"
    t.boolean "Estufa"
    t.boolean "Refrigerador"
    t.boolean "Televisor"
    t.boolean "Lavadora"
    t.boolean "Sala"
    t.boolean "Comedor"
    t.integer "EstadoGarantia", limit: 1
    t.integer "AcabadosVivienda", limit: 1
    t.boolean "Automovil"
    t.string "Marca", limit: 30
    t.string "Modelo", limit: 30
    t.text "Observaciones", size: :tiny
    t.index ["IDDiagnostico"], name: "fk_CondicionesVivienda_DiagnosticoSocioEconomico"
  end

  create_table "convenios", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.integer "IDSolicitud", null: false, unsigned: true
    t.integer "IDPagare", null: false, unsigned: true
    t.date "FechaAcuerdo", null: false
    t.datetime "Created_at", null: false
    t.integer "IDUsuario", null: false, unsigned: true
    t.string "Status", limit: 45, null: false
    t.integer "Folio", null: false, unsigned: true
  end

  create_table "cortecaja", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.datetime "Fecha"
    t.integer "Folio", default: 0, unsigned: true
    t.string "Caja", limit: 50
    t.integer "IDUsuario", unsigned: true
    t.date "FechaInicial"
    t.date "FechaFinal"
    t.decimal "CajaAnterior", precision: 14, scale: 4, default: "0.0"
    t.decimal "eCapital", precision: 14, scale: 4, default: "0.0"
    t.decimal "eIntereses", precision: 14, scale: 4, default: "0.0"
    t.decimal "eIvaInteres", precision: 14, scale: 4, default: "0.0"
    t.decimal "eInteresMoroso", precision: 14, scale: 4, default: "0.0"
    t.decimal "eIvaInteresMoroso", precision: 14, scale: 4, default: "0.0"
    t.decimal "eGastosAdmin", precision: 14, scale: 4, default: "0.0"
    t.decimal "PaseBoveda", precision: 14, scale: 4, default: "0.0"
    t.decimal "sCapital", precision: 14, scale: 4, default: "0.0"
    t.decimal "sIntereses", precision: 14, scale: 4, default: "0.0"
    t.decimal "sIvaInteres", precision: 14, scale: 4, default: "0.0"
    t.decimal "sInteresMoroso", precision: 14, scale: 4, default: "0.0"
    t.decimal "sIvaInteresMoroso", precision: 14, scale: 4, default: "0.0"
    t.decimal "sGastosAdmin", precision: 14, scale: 4, default: "0.0"
    t.decimal "EfectivoFinal", precision: 14, scale: 4, default: "0.0"
    t.decimal "TotalArqueo", precision: 14, scale: 4, default: "0.0"
    t.decimal "CajaActual", precision: 14, scale: 4, default: "0.0"
    t.decimal "DotacionesCaja", precision: 14, scale: 4, default: "0.0"
    t.string "PC", limit: 45
    t.decimal "TotalEntradas", precision: 14, scale: 4, default: "0.0"
    t.decimal "TotaSalidas", precision: 14, scale: 4, default: "0.0"
    t.decimal "eComision", precision: 14, scale: 4, default: "0.0"
  end

  create_table "cuentasgastos", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "Cuenta", limit: 12, default: "511101"
    t.datetime "Fecha"
    t.string "Descripcion", limit: 45
  end

  create_table "datosgarantia", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDSolicitud"
    t.boolean "IFE", default: false
    t.boolean "ComprobanteDomicilio", default: false
    t.boolean "ActaNacimiento", default: false
    t.boolean "RFC", default: false
    t.boolean "ActaConstitutiva", default: false
    t.boolean "Predial", default: false
    t.boolean "ActaMatrimonio", default: false
    t.text "Observaciones", size: :tiny
    t.text "TipoGarantia", size: :tiny, comment: "Clave de Tipos garantias"
    t.boolean "CURP", default: false
    t.string "TipoImueble", limit: 45, comment: "'Se guarada la clave de tipos_inmuebles'"
    t.decimal "ValorCatastralInmueble", precision: 14, scale: 2, default: "0.0"
    t.string "CodigoPostalInmueble", limit: 5
    t.string "FolioInmueble", limit: 45
    t.boolean "GarantiaPropia", default: true
    t.string "TipoPersonaGarante", limit: 45
    t.string "NombresGarante", limit: 60
    t.string "PaternoGrarante", limit: 60
    t.string "MaternoGarante", limit: 60
    t.datetime "FechaNacimientoGarante", default: "1900-01-01 01:01:01"
    t.string "RfcGarante", limit: 15
    t.string "CurpGarante", limit: 25
    t.string "RazonSocialGarante", limit: 60
    t.text "DescripcionGarantia"
    t.index ["IDSolicitud"], name: "fk_DatosGarantia_SolicitudCredito"
  end

  create_table "dependienteseconomicos", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDInformacionEconomica"
    t.integer "Cantidad", limit: 1, default: 0
    t.integer "TipoDependiente", limit: 1, default: 0
    t.decimal "Gasto", precision: 14, scale: 4, default: "0.0"
    t.index ["IDInformacionEconomica"], name: "fk_DependientesEconomicos_Informacion Economica"
  end

  create_table "dependientesestudioeconomico", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDEstudioEconomico"
    t.integer "Cantidad", limit: 1, default: 0
    t.integer "TipoDependiente", limit: 1, default: 0
    t.decimal "Gasto", precision: 14, scale: 4, default: "0.0"
    t.index ["IDEstudioEconomico"], name: "fk_DependientesEstudioEconomico_EstudioEconomico"
  end

  create_table "detallefactura", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDFactura"
    t.integer "Cantidad"
    t.string "Unidad", limit: 5
    t.string "Codigo", limit: 60
    t.string "Concepto"
    t.float "ValorUnitario", limit: 53
    t.float "Importe", limit: 53
    t.index ["ID"], name: "Id"
    t.index ["IDFactura"], name: "Idfactura"
  end

  create_table "diagnosticosocioeconomico", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDCliente"
    t.datetime "Fecha"
    t.string "Verificador", limit: 60
    t.boolean "InformacionCorrecta"
    t.text "Comentarios", size: :tiny
    t.string "Atendio", limit: 60
    t.text "Notas", size: :tiny
    t.index ["IDCliente"], name: "fk_DiagnosticoSocioEconomico_SolicitudCredito"
  end

  create_table "diasfestivos", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.date "Fecha", null: false
    t.integer "Activo", null: false, unsigned: true
    t.boolean "Fijo", default: false
  end

  create_table "egresosmensuales", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDInformacionEconomica"
    t.decimal "cvMercancia", precision: 14, scale: 4, default: "0.0"
    t.decimal "cvLuz", precision: 14, scale: 4, default: "0.0"
    t.decimal "cvAgua", precision: 14, scale: 4, default: "0.0"
    t.decimal "cvCombustibles", precision: 14, scale: 4, default: "0.0"
    t.decimal "cvTelefono", precision: 14, scale: 4, default: "0.0"
    t.decimal "cvPapeleria", precision: 14, scale: 4, default: "0.0"
    t.decimal "cvConsumibles", precision: 14, scale: 4, default: "0.0"
    t.decimal "cvComidas", precision: 14, scale: 4, default: "0.0"
    t.decimal "cvOtrosCostos", precision: 14, scale: 4, default: "0.0"
    t.decimal "cfRentaLocal", precision: 14, scale: 4, default: "0.0"
    t.decimal "cfEmpleados", precision: 14, scale: 4, default: "0.0"
    t.decimal "cfOtrosCostos", precision: 14, scale: 4, default: "0.0"
    t.decimal "cfPagoCasa", precision: 14, scale: 4, default: "0.0"
    t.decimal "cfRenta", precision: 14, scale: 4, default: "0.0"
    t.decimal "cfAportacion", precision: 14, scale: 4, default: "0.0"
    t.decimal "cfLuz", precision: 14, scale: 4, default: "0.0"
    t.decimal "cfAgua", precision: 14, scale: 4, default: "0.0"
    t.decimal "cfGas", precision: 14, scale: 4, default: "0.0"
    t.decimal "cfTelefono", precision: 14, scale: 4, default: "0.0"
    t.decimal "cfTV", precision: 14, scale: 4, default: "0.0"
    t.decimal "cfComida", precision: 14, scale: 4, default: "0.0"
    t.decimal "cfDeudas", precision: 14, scale: 4, default: "0.0"
    t.decimal "cfOtrosGastos", precision: 14, scale: 4, default: "0.0"
    t.index ["IDInformacionEconomica"], name: "fk_EgresosMensuales_Informacion Economica"
  end

  create_table "estadocivil", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "EstadoCivil", limit: 50
  end

  create_table "estados", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.string "Clave", limit: 45, null: false
    t.string "Descripcion", limit: 45, null: false
    t.string "Codigo", limit: 60
  end

  create_table "estudioeconomico", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDCliente"
    t.datetime "Fecha"
    t.string "Verificador", limit: 60
    t.text "DescripcionNegocio", size: :tiny
    t.text "DescripcionProyecto", size: :tiny
    t.integer "TipoDeudas", unsigned: true
    t.decimal "Pago", precision: 14, scale: 4
    t.index ["IDCliente"], name: "fk_EstudioEconomico_SolicitudCredito"
  end

  create_table "etiquetados", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.string "Nombre", limit: 105, null: false
    t.string "Descripcion", limit: 75, null: false
    t.integer "Orden", null: false, unsigned: true
    t.integer "IDCliente", null: false, unsigned: true
    t.datetime "Fecha", null: false
    t.integer "IDUsuario", null: false, unsigned: true
    t.integer "Activo", default: 1, null: false, unsigned: true
  end

  create_table "etiquetas", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.string "Nombre", limit: 105, null: false
    t.integer "IDRelacion", default: 0, unsigned: true
  end

  create_table "factura_parametros", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "utf8", force: :cascade do |t|
    t.text "RutaClavePrivada"
    t.text "RutaCertificacion"
    t.string "Clave", limit: 60
    t.text "RutaParaXml"
    t.integer "FolioInicial", default: 0, unsigned: true
    t.string "UsuarioTimbrar", limit: 60
    t.string "ContraTimbrar", limit: 60
    t.string "Serie", limit: 60
  end

  create_table "facturas", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "Serie", limit: 10
    t.string "Folio", limit: 10
    t.datetime "Fecha"
    t.integer "IDCliente", default: 0
    t.float "Subtotal", limit: 53, default: 0.0
    t.float "ImporteIva", limit: 53, default: 0.0
    t.float "Total", limit: 53, default: 0.0
    t.string "Observaciones", limit: 250
    t.integer "IDUsuario", default: 0
    t.integer "TipoFactura", default: 0
    t.index ["ID"], name: "Id"
  end

  create_table "folios", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "TipoFolio"
    t.string "Valor", limit: 100
    t.index ["TipoFolio"], name: "TipoFolio"
  end

  create_table "fotos", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "utf8", force: :cascade do |t|
    t.string "Nombre", limit: 45
    t.binary "Foto", size: :medium
    t.integer "IDCliente", default: 0, unsigned: true
  end

  create_table "fotos_clientes", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "utf8", force: :cascade do |t|
    t.string "Nombre", limit: 45
    t.binary "Foto", size: :medium
    t.integer "IDCliente", default: 0, unsigned: true
  end

  create_table "garantias", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDDiagnostico"
    t.boolean "GarantiaPrendaria"
    t.text "Descripcion", size: :tiny
    t.string "Propietario", limit: 45
    t.decimal "ValorComercial", precision: 14, scale: 4, default: "0.0"
    t.integer "EstadoGarantia", limit: 1
    t.index ["IDDiagnostico"], name: "fk_Garantias_DiagnosticoSocioEconomico"
  end

  create_table "gastos", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDGasto"
    t.integer "Folio"
    t.datetime "Fecha"
    t.string "Concepto", limit: 60
    t.decimal "Importe", precision: 14, scale: 4, default: "0.0"
    t.integer "IDUsuario", default: 0
    t.index ["IDGasto"], name: "fk_Gastos_CuentasGastos"
    t.index ["IDUsuario"], name: "fk_Gastos_Usuarios1"
  end

  create_table "gastosadministrativos", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "Inicial"
    t.integer "Final"
    t.float "Valor", limit: 53
  end

  create_table "gaval", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "Nombre", limit: 60, null: false
    t.string "Apellidos", limit: 60, null: false
    t.string "Direccion", limit: 120, null: false
    t.string "Colonia", limit: 30, null: false
    t.string "Municipio", limit: 30, null: false
    t.string "Ciudad", limit: 30, null: false
    t.string "Estado", limit: 30, null: false
    t.string "CodigoPostal", limit: 20, null: false
    t.string "Telefono", limit: 20, null: false
    t.string "TelTrabajo", limit: 20, null: false
    t.integer "IDPlazo", default: 0, null: false, unsigned: true
    t.decimal "Prestamo", precision: 15, scale: 5, default: "0.0", null: false
    t.decimal "Intereses", precision: 15, scale: 5, default: "0.0", null: false
    t.decimal "PagoSemanal", precision: 15, scale: 5, default: "0.0", null: false
    t.integer "IDGrupo", null: false, unsigned: true
    t.integer "IDCliente", null: false, unsigned: true
  end

  create_table "grupoaval", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDPlaza", null: false, unsigned: true
    t.integer "IDPromotor", null: false, unsigned: true
    t.string "Descripcion", limit: 30, null: false
    t.string "NombreGrupo", limit: 30, default: "", null: false
    t.integer "IDPresidente", default: 0, null: false, unsigned: true
    t.integer "IDTesorero", default: 0, null: false, unsigned: true
    t.integer "IDSecretario", default: 0, null: false, unsigned: true
    t.decimal "PorcGarantia", precision: 10, scale: 2, default: "0.0", null: false, unsigned: true
    t.integer "Solicitud", unsigned: true
    t.integer "Folio"
  end

  create_table "historial_cambios", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.string "Campo", limit: 45, null: false
    t.string "Valor", limit: 45, null: false
    t.integer "IDRegistro", null: false, unsigned: true
    t.string "Tabla", limit: 75, null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "informacioneconomica", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDCliente"
    t.datetime "Fecha"
    t.string "Verificador", limit: 80
    t.integer "IDUsuario"
    t.decimal "CantidadAspirar", precision: 10, scale: 2, default: "0.0"
    t.decimal "TotalMes", precision: 10, scale: 2, default: "0.0"
    t.index ["IDCliente"], name: "fk_InformacionEconomica_SolicitudCredito"
  end

  create_table "ingresosmensuales", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDInformacionEconomica"
    t.decimal "imSemanalesCliente", precision: 14, scale: 4, default: "0.0"
    t.decimal "imQuincenalesCliente", precision: 14, scale: 4, default: "0.0"
    t.decimal "imMensualesCliente", precision: 14, scale: 4, default: "0.0"
    t.decimal "imEventualCliente", precision: 14, scale: 4, default: "0.0"
    t.decimal "imOtrosCliente", precision: 14, scale: 4, default: "0.0"
    t.decimal "imSemanalesConyuge", precision: 14, scale: 4, default: "0.0"
    t.decimal "imQuincenalesConyuge", precision: 14, scale: 4, default: "0.0"
    t.decimal "imMensualesConyuge", precision: 14, scale: 4, default: "0.0"
    t.decimal "imEventualConyuge", precision: 14, scale: 4, default: "0.0"
    t.decimal "imOtrosConyuge", precision: 14, scale: 4, default: "0.0"
    t.decimal "ivSemanalesCliente", precision: 14, scale: 4, default: "0.0"
    t.decimal "ivQuincenalesCliente", precision: 14, scale: 4, default: "0.0"
    t.decimal "ivMensualesCliente", precision: 14, scale: 4, default: "0.0"
    t.decimal "ivEventualesCliente", precision: 14, scale: 4, default: "0.0"
    t.decimal "ivOtrosCliente", precision: 14, scale: 4, default: "0.0"
    t.decimal "ivSemanalesConyuge", precision: 14, scale: 4, default: "0.0"
    t.decimal "ivQuincenalesConyuge", precision: 14, scale: 4, default: "0.0"
    t.decimal "ivMensualesConyuge", precision: 14, scale: 4, default: "0.0"
    t.decimal "ivEventualesConyuge", precision: 14, scale: 4, default: "0.0"
    t.decimal "ivOtrosConyuge", precision: 14, scale: 4, default: "0.0"
    t.index ["IDInformacionEconomica"], name: "fk_IngresosMensuales_Informacion Economica"
  end

  create_table "jwt_denylist", charset: "utf8mb4", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", precision: 6, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "memoriaegresos", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDEstudioEconomico", default: 0
    t.decimal "cfRentaLocal", precision: 14, scale: 4, default: "0.0"
    t.decimal "cfEmpleados", precision: 14, scale: 4, default: "0.0"
    t.decimal "cfOtrosCostos", precision: 14, scale: 4, default: "0.0"
    t.decimal "cvMercancia", precision: 14, scale: 4, default: "0.0"
    t.decimal "cvAgua", precision: 14, scale: 4, default: "0.0"
    t.decimal "cvLuz", precision: 14, scale: 4, default: "0.0"
    t.decimal "cvCombustible", precision: 14, scale: 4, default: "0.0"
    t.decimal "cvTelefono", precision: 14, scale: 4, default: "0.0"
    t.decimal "cvPapeleria", precision: 14, scale: 4, default: "0.0"
    t.decimal "cvConsumibles", precision: 14, scale: 4, default: "0.0"
    t.decimal "cvComidas", precision: 14, scale: 4, default: "0.0"
    t.decimal "cvOtrosCostos", precision: 14, scale: 4, default: "0.0"
    t.integer "TipoCasa", limit: 1, default: 0
    t.decimal "PagoCasa", precision: 14, scale: 4, default: "0.0"
    t.decimal "EnergiaElectrica", precision: 14, scale: 4, default: "0.0"
    t.decimal "AyudaDomestica", precision: 14, scale: 4, default: "0.0"
    t.decimal "Telefono", precision: 14, scale: 4, default: "0.0"
    t.decimal "TVCable", precision: 14, scale: 4, default: "0.0"
    t.decimal "Agua", precision: 14, scale: 4, default: "0.0"
    t.decimal "Gas", precision: 14, scale: 4, default: "0.0"
    t.decimal "Otros", precision: 14, scale: 4, default: "0.0"
    t.index ["IDEstudioEconomico"], name: "fk_MemoriaEgresos_EstudioEconomico"
  end

  create_table "memoriaingresos", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDEstudioEconomico"
    t.decimal "AsalariadoSemanal", precision: 14, scale: 4, default: "0.0"
    t.decimal "AsalariadoQuincenal", precision: 14, scale: 4, default: "0.0"
    t.decimal "AsalariadoMensual", precision: 14, scale: 4, default: "0.0"
    t.decimal "AsalariadoEventual", precision: 14, scale: 4, default: "0.0"
    t.decimal "AsalariadoOtro", precision: 14, scale: 4, default: "0.0"
    t.decimal "EmpresarioSemanal", precision: 14, scale: 4, default: "0.0"
    t.decimal "EmpresarioQuincenal", precision: 14, scale: 4, default: "0.0"
    t.decimal "EmpresarioMensual", precision: 14, scale: 4, default: "0.0"
    t.decimal "EmpresarioEventual", precision: 14, scale: 4, default: "0.0"
    t.decimal "EmpresarioOtro", precision: 14, scale: 4, default: "0.0"
    t.decimal "Lunes", precision: 14, scale: 4, default: "0.0"
    t.decimal "Martes", precision: 14, scale: 4, default: "0.0"
    t.decimal "Miercoles", precision: 14, scale: 4, default: "0.0"
    t.decimal "Jueves", precision: 14, scale: 4, default: "0.0"
    t.decimal "Viernes", precision: 14, scale: 4, default: "0.0"
    t.decimal "Sabado", precision: 14, scale: 4, default: "0.0"
    t.decimal "Domingo", precision: 14, scale: 4, default: "0.0"
    t.decimal "LugarEstablecido", precision: 14, scale: 4, default: "0.0"
    t.index ["IDEstudioEconomico"], name: "fk_MemoriaIngresos_EstudioEconomico"
  end

  create_table "movimientos", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDCliente", default: 0
    t.integer "IDSolicitud", default: 0
    t.bigint "Folio"
    t.datetime "Fecha"
    t.string "Referencia", limit: 100
    t.string "Descripcion"
    t.decimal "Cargo", precision: 12, scale: 4, default: "0.0"
    t.decimal "Abono", precision: 12, scale: 4, default: "0.0"
    t.integer "IDUsuario", default: 0
    t.boolean "Cancelado", default: false
    t.string "MotivoCancelacion"
    t.integer "IDUsuarioCancelado", default: 0
    t.string "PC", limit: 20
    t.boolean "Parcial", default: false, unsigned: true
    t.datetime "FechaAplicado", default: "1900-01-01 00:00:00"
    t.text "Observaciones"
    t.index ["IDCliente"], name: "fk_Movimientos_Clientes"
    t.index ["IDUsuario"], name: "fk_Movimientos_Usuarios"
    t.index ["IDUsuarioCancelado"], name: "fk_Movimientos_Usuarios1"
  end

  create_table "movimientosbancos", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.datetime "Fecha"
    t.integer "Folio"
    t.boolean "Cancelado"
    t.datetime "FechaMovimiento"
    t.boolean "Deposito"
    t.string "Concepto", limit: 80
    t.decimal "Cargo", precision: 14, scale: 4, default: "0.0"
    t.decimal "Abono", precision: 14, scale: 4, default: "0.0"
    t.integer "TipoMov", limit: 1
    t.integer "IDUsuario"
  end

  create_table "municipios", id: { type: :integer, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.string "Descripcion", limit: 105
    t.integer "IDEstado", unsigned: true
    t.string "CodigoPostal", limit: 10
  end

  create_table "obligadosolidario", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDDiagnostico"
    t.string "ApellidoPaterno", limit: 45
    t.string "ApellidoMaterno", limit: 45
    t.string "Nombre", limit: 40
    t.integer "Edad"
    t.string "Direccion", limit: 80
    t.string "Colonia", limit: 30
    t.string "Municipio", limit: 30
    t.string "Estado", limit: 30
    t.string "Telefono", limit: 20
    t.string "Ocupacion", limit: 60
    t.string "LugarTrabajo", limit: 80
    t.string "Puesto", limit: 60
    t.decimal "Ingreso", precision: 14, scale: 4, default: "0.0"
    t.text "Comentarios", size: :tiny
    t.index ["IDDiagnostico"], name: "fk_ObligadoSolidario_DiagnosticoSocioEconomico"
  end

  create_table "otrosmovimientos", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.datetime "Fecha"
    t.integer "Folio", default: 0
    t.integer "IDBanco", default: 0
    t.integer "IDConcepto", default: 0
    t.integer "IDUsuario", default: 0
    t.string "Referencia"
    t.decimal "Importe", precision: 14, scale: 4, default: "0.0"
  end

  create_table "pagares", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDSolicitud", default: 0
    t.integer "NoPago", default: 0
    t.bigint "Folio", default: 0
    t.decimal "SaldoInsoluto", precision: 14, scale: 4, default: "0.0"
    t.decimal "Interes", precision: 14, scale: 4, default: "0.0"
    t.decimal "IVA", precision: 14, scale: 4, default: "0.0"
    t.decimal "Amortizacion", precision: 14, scale: 4, default: "0.0"
    t.decimal "GastosAdministrativo", precision: 14, scale: 4, default: "0.0"
    t.decimal "InteresesMoratorios", precision: 14, scale: 4, default: "0.0"
    t.decimal "IVAInteresesMoratorios", precision: 14, scale: 4, default: "0.0"
    t.date "Vencimiento"
    t.boolean "Cancelado", default: false
    t.boolean "Vencido", default: false
    t.boolean "Pagado", default: false
    t.datetime "FechaPago"
    t.integer "IDUsuario", default: 0
    t.decimal "AmortizacionInt", precision: 14, scale: 4, default: "0.0"
    t.decimal "AmortizacionParcial", precision: 14, scale: 4, default: "0.0"
    t.decimal "AmortizacionIntParcial", precision: 14, scale: 4, default: "0.0"
    t.datetime "FechaParcial"
    t.boolean "Parcial", default: false, unsigned: true
    t.decimal "PagoIntMoratorios", precision: 14, scale: 4, default: "0.0"
    t.decimal "PagoIvaMoratorios", precision: 14, scale: 4, default: "0.0"
    t.datetime "FechaPagoMoroso"
    t.datetime "VencimientoOriginal", default: "1900-01-01 01:01:01"
    t.integer "Convenio", default: 0, unsigned: true
    t.text "Observaciones"
    t.integer "IDPagareRelacion", default: 0, unsigned: true
    t.decimal "ImportePromesa", precision: 12, scale: 2, default: "0.0"
    t.decimal "CargoA", precision: 12, scale: 2
    t.decimal "CargoB", precision: 12, scale: 2
    t.integer "IDOrigen", unsigned: true
    t.index ["IDSolicitud", "Cancelado"], name: "Ix_solicit_cancelado"
    t.index ["IDSolicitud"], name: "fk_Pagares_Solicitud"
    t.index ["IDUsuario"], name: "fk_Pagares_Usuarios"
  end

  create_table "pagos_comision", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.integer "IDPagare", null: false, unsigned: true
    t.integer "FolioTicket", null: false, unsigned: true
    t.decimal "PorcentajeComision", precision: 12, scale: 2, null: false
    t.decimal "ImporteComision", precision: 12, scale: 2, null: false
    t.datetime "FechaPago", null: false
    t.integer "IDAgente", null: false, unsigned: true
    t.integer "Cancelado", default: 0, unsigned: true
    t.text "Observaciones"
  end

  create_table "parametros", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "TipoParametro"
    t.string "Valor", limit: 100
    t.index ["TipoParametro"], name: "TipoParametro"
  end

  create_table "permisos", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDUsuario"
    t.integer "TipoPermiso"
    t.boolean "Valor", default: false
    t.index ["IDUsuario"], name: "fk_Permisos_Usuarios"
  end

  create_table "productosgastosfinancieros", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.datetime "Fecha"
    t.integer "Folio"
    t.integer "IDBanco"
    t.integer "IDUsuario"
    t.boolean "Producto", default: false
    t.string "Concepto"
    t.decimal "Importe", precision: 14, scale: 4, default: "0.0"
  end

  create_table "profesiones", id: { type: :integer, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.string "Descripcion", limit: 105, null: false
  end

  create_table "referencias", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "utf8", force: :cascade do |t|
    t.string "Paterno", limit: 60
    t.string "Materno", limit: 60
    t.string "Nombre", limit: 60
    t.string "Parentesco", limit: 45
    t.integer "Conocido", default: 0, unsigned: true
    t.string "NombreComercial", limit: 70
    t.string "TipoPrestamo", limit: 45
    t.string "Telefono", limit: 45
    t.integer "IDCliente", default: 0, unsigned: true
    t.integer "IDUsuario", default: 0, unsigned: true
    t.integer "TipoReferencia", unsigned: true
    t.datetime "Registrado", default: "1900-01-01 00:00:00"
    t.text "Domicilio"
    t.text "Comentarios"
  end

  create_table "regimensocial", primary_key: "ID", id: { type: :integer, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.string "Regimen", limit: 60, null: false
  end

  create_table "solicitudcredito", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDCliente", default: 0
    t.integer "IDUsuario", default: 0
    t.integer "IDTipoPrestamo", default: 0
    t.integer "TipoCredito", default: 0
    t.bigint "Folio", default: 0
    t.string "sFolio", limit: 30
    t.datetime "Fecha", default: "1900-01-01 00:00:00"
    t.decimal "Credito", precision: 14, scale: 4, default: "0.0"
    t.integer "Plazo", default: 0
    t.float "Tasa", default: 0.0
    t.decimal "Pago", precision: 14, scale: 4, default: "0.0"
    t.boolean "IVA", default: false
    t.datetime "FechaContrato", default: "1900-01-01 00:00:00"
    t.string "Autorizo", limit: 80, default: "0"
    t.integer "FolioContrato", default: 0
    t.boolean "Autorizado", default: false
    t.boolean "Cancelado", default: false
    t.boolean "Liquidado", default: false
    t.datetime "FechaVencimiento", default: "1900-01-01 00:00:00"
    t.integer "Status", default: 0
    t.decimal "SaldoInsoluto", precision: 14, scale: 4, default: "0.0"
    t.boolean "Rechazado", default: false
    t.string "ComentarioRechazado"
    t.datetime "FechaRechazado"
    t.integer "Origen", default: 0
    t.boolean "Restructurado", default: false
    t.datetime "FechaRestructuracion"
    t.decimal "MontoRestructurar", precision: 14, scale: 4, default: "0.0"
    t.integer "IDPlazo", default: 0, null: false, unsigned: true
    t.boolean "Garantia", default: false
    t.integer "IdTipoAlerta", default: 0, unsigned: true
    t.integer "IdInstrumentoMonetario", default: 0, unsigned: true
    t.string "Banco", limit: 25
    t.string "FolioTrasferencia", limit: 45
    t.string "FolioCheque", limit: 30
    t.string "NumeroCuenta", limit: 45
    t.datetime "FechaEntregaPrestamo", default: "1900-01-01 01:01:01"
    t.integer "PeriodoPago", default: 0, comment: "54=Semanal, 24 Quincenal, 12 Mensual 6 Bimestral 2 Semestral 1 Anual", unsigned: true
    t.decimal "CAT", precision: 12, scale: 2, default: "0.0"
    t.decimal "PorcentajeIVA", precision: 12, scale: 2, default: "0.0"
    t.decimal "ComisionApertura", precision: 12, scale: 2, default: "0.0", comment: "Importe de comision por apertura"
    t.decimal "PorcentajeMora", precision: 12, scale: 2, default: "0.0"
    t.decimal "TotalCreditoOtorgado", precision: 12, scale: 2, default: "0.0"
    t.datetime "FechaPrimerPago", default: "1900-01-01 01:01:01"
    t.decimal "PorceAnualDeMoraDiaria", precision: 12, scale: 2, default: "0.0"
    t.decimal "PagoSinIVA", precision: 12, scale: 2, default: "0.0"
    t.integer "ConSaldoInsoluto", default: 1, unsigned: true
    t.integer "IDAgente", default: 0, unsigned: true
    t.string "MotivoCambioStatus", limit: 200, default: "-"
    t.string "AbonoCapital", limit: 45
    t.string "TipoInteres", limit: 45
    t.string "Semaforo", limit: 20, default: "\"", null: false
    t.integer "cierre", default: 0, null: false, unsigned: true
    t.string "AplicarMoraMensual", limit: 15, default: "SI"
    t.boolean "TieneFactoraje", default: false
    t.decimal "ImporteFactoraje", precision: 12, scale: 2, default: "0.0"
    t.decimal "PorcentajeComision", precision: 10, scale: 2, default: "0.0"
    t.decimal "CapitalCondonado", precision: 12, scale: 2, default: "0.0"
    t.decimal "InteresesCapitalizar", precision: 12, scale: 2, default: "0.0"
    t.boolean "Acumulado", default: false
    t.text "DestinoDeCredito"
    t.decimal "InteresesCondonados", precision: 12, scale: 2, default: "0.0"
    t.integer "IDOficialCobro", unsigned: true
    t.string "DiaPago", limit: 45
    t.decimal "CargoA", precision: 12, scale: 2
    t.decimal "CargoB", precision: 12, scale: 2
    t.index ["IDCliente"], name: "fk_Solicitud_Clientes"
    t.index ["IDTipoPrestamo"], name: "fk_SolicitudCredito_TipoPrestamo"
    t.index ["IDUsuario"], name: "fk_Solicitud_Usuarios"
  end

  create_table "tipopagos", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDPagare"
    t.integer "TipoPago"
    t.string "Folio", limit: 20
    t.string "Autorizacion", limit: 20
    t.decimal "Importe", precision: 14, scale: 4
    t.boolean "Parcial", default: false, unsigned: true
    t.string "FormaPago", limit: 45
    t.index ["IDPagare"], name: "fk_TipoPago_Pagares"
  end

  create_table "tipoplazo", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "TipoCredito", null: false, unsigned: true
    t.integer "Plazo", null: false, unsigned: true
  end

  create_table "tipoprestamo", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "TipoPrestamo", limit: 60
    t.decimal "Tasa", precision: 12, scale: 4
    t.decimal "ImportePagoTardio", precision: 12, scale: 2
    t.string "Periodo", limit: 45
    t.decimal "Comision", precision: 12, scale: 4
    t.decimal "CAT", precision: 12, scale: 4
    t.string "AbonoCapital", limit: 45
    t.string "TipoInteres", limit: 45
    t.decimal "IVA", precision: 12, scale: 2, default: "0.0"
    t.string "AbonoPromesa", limit: 45, default: "SI"
    t.string "AplicarMoraMensual", limit: 15, default: "SI"
    t.string "Status", limit: 15, default: "Activo"
    t.decimal "CargoA", precision: 12, scale: 2, default: "0.0"
    t.decimal "CargoB", precision: 12, scale: 2, default: "0.0"
    t.string "Sabado", limit: 12
    t.string "Domingo", limit: 12
    t.integer "Plazo", unsigned: true
    t.decimal "Mes", precision: 12, scale: 2, default: "0.0"
  end

  create_table "users", charset: "latin1", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", limit: 100
    t.string "lastname", limit: 100
    t.string "cellphone", limit: 15
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "agent_id"
    t.index ["agent_id"], name: "index_users_on_agent_id", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "usuarios", primary_key: "ID", id: :integer, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "Usuario", limit: 45
    t.string "Nombre", limit: 120
    t.string "Password", limit: 45
    t.string "PasswordAutorizoPrestamos", limit: 45
    t.index ["ID"], name: "fk_Usuarios_Auxiliar1"
    t.index ["ID"], name: "fk_Usuarios_Boveda1"
    t.index ["ID"], name: "fk_Usuarios_MovimientosBancos1"
    t.index ["ID"], name: "fk_Usuarios_ProductosGastosFinancieros1"
    t.index ["Usuario"], name: "fk_Usuarios_OtrosMovimientos1"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
