view: funil_etus {
  derived_table: {
    sql: SELECT date AS DATA, page_path AS PAGINA, SUM(pageviews) AS PAGEVIEWS,
      CASE WHEN page_path LIKE '%c6%' THEN 'C6'
      WHEN (page_path LIKE '%consignado-bmg%' OR page_path LIKE '%sobre-o-cartao-de-credito-bmg%' OR page_path LIKE '%como-solicitar-bmg%') THEN 'CONSIGNADO BMG'
      WHEN page_path LIKE '%cartao-de-credito-bmg-card%' THEN 'BMG CARD'
      WHEN (page_path LIKE '%super-digital%' OR page_path LIKE '%superdigital%') THEN 'SUPER DIGITAL'
      WHEN page_path LIKE '%nubank%' THEN 'NUBANK'
      END AS BANCO,
      CASE WHEN (source LIKE '%facebok%' OR source LIKE '%Facebok%') THEN 'FACEBOOK'
      WHEN (source LIKE '%google%' OR source LIKE '%youtube%') THEN 'GOOGLE'
      WHEN source LIKE '%taboola%' THEN 'TABOOLA'
      WHEN source LIKE '%outbrain%' THEN 'OUTBRAIN'
      WHEN source LIKE '%newsletter%' THEN 'NEWSLETTER'
      WHEN source LIKE '%xandr%' THEN 'XANDR'
      ELSE 'OUTROS' END AS SOURCE,
      CASE WHEN (page_path = 'unum.com.br/cartao-de-credito-c6-bank/'
      OR page_path = 'unum.com.br/cartao-de-credito-consignado-bmg/'
      OR page_path = 'unum.com.br/cartao-de-credito-bmg-card/'
      OR page_path = 'unum.com.br/cartao-pre-super-digital/'
      OR page_path = 'unum.com.br/conheca-o-cartao-de-credito-da-nubank/') THEN 1
      WHEN (page_path = 'unum.com.br/solicitar-cartao-de-credito-c6-bank/'
      OR page_path = 'unum.com.br/sobre-o-cartao-de-credito-bmg/'
      OR page_path = 'unum.com.br/sobre-o-superdigital/'
      OR page_path = 'unum.com.br/solicitar-cartao-de-credito-nubank/') THEN 2
      ELSE 3 END AS PASSO

      FROM `etusbg.ga.ga_total`

      WHERE date >= '2020-01-01'
      AND source NOT IN ('solicitar-cartao')
      AND (page_path = 'unum.com.br/cartao-de-credito-c6-bank/'
      OR page_path = 'unum.com.br/cartao-de-credito-consignado-bmg/'
      OR page_path = 'unum.com.br/cartao-de-credito-bmg-card/'
      OR page_path = 'unum.com.br/cartao-pre-super-digital/'
      OR page_path = 'unum.com.br/conheca-o-cartao-de-credito-da-nubank/'
      OR page_path = 'unum.com.br/solicitar-cartao-de-credito-c6-bank/'
      OR page_path = 'unum.com.br/sobre-o-cartao-de-credito-bmg/'
      OR page_path = 'unum.com.br/sobre-o-superdigital/'
      OR page_path = 'unum.com.br/solicitar-cartao-de-credito-nubank/'
      OR page_path = 'unum.com.br/solicite/como-solicitar-c6-bank/'
      OR page_path = 'unum.com.br/solicite/como-solicitar-bmg/'
      OR page_path = 'unum.com.br/solicite/como-solicitar-super-digital/'
      OR page_path = 'unum.com.br/solicite/como-solicitar-nubank/')

      GROUP BY date, page_path, source

      ORDER BY DATA, SOURCE, BANCO, PASSO
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: data {
    type: time
    sql: ${TABLE}.DATA ;;
  }

  dimension: pagina {
    type: string
    sql: ${TABLE}.PAGINA ;;
  }

  measure: pageviews {
    type: sum
    sql: ${TABLE}.PAGEVIEWS ;;
  }

  dimension: banco {
    type: string
    sql: ${TABLE}.BANCO ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.SOURCE ;;
  }

  dimension: passo {
    type: number
    sql: ${TABLE}.PASSO ;;
  }

  set: detail {
    fields: [
      data_time,
      pagina,
      pageviews,
      banco,
      source,
      passo
    ]
  }
}
