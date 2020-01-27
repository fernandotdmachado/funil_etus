connection: "etusbg_connector"

datagroup: funil_etus_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: funil_etus_default_datagroup

include: "/view/*.view"

explore: funil_etus {
  label: "Funil - Etus"
}
