contact_text = """
  <p>
  <h2>Sharee</h2>
  Nám. SNP 30 <br>
  811 01 Bratislava <br>
  <br>
  0948 828 228 <br>
  info@sharee.io <br>
  </p>
  """

tos_text = """
  <p>
   cup of coffeescript
  </p>
  """

faq_text = """
  asd
  """

about_text = """
  <p>Sharee je jedinečný nástroj na podporu predaja, ktorý umožňuje návštevníkom stránky zdieľať produkty obchodníka a získať tak províziu z ich predaja.</p>
  <p>Sharee sa postará o meranie všetkých zdieľaní, pridelenie provízií konkrétnym užívateľom a ich následné vyplatenie.</p>
  <p>Po prihlásení sa do aplikácie, môžu užívatelia sledovať štatistiky o svojich aktivitách a vyplatiť si svoju províziu.</p>
  <p>Implementácia pre obchodníkov je veľmi jednoduchá a prebieha podobne ako so systémom Google Analytics.</p>
  <p>Obchodník si na sharee.io vytvorí svoju kampaň a stanoví jej parametre. Provízia z predaja je jediný náklad na službu, čiže zaplatí až potom, ako predal svoj produkt, bez skrytých poplatkov a rizika.</p>
  <p>Sharee zvyšuje predaj obchodníkom a odmeňuje za to užívateľov, ktorí produkty zdieľali a pomohli propagovať.</p>
  """

ready = ->
  $( "#contact-overlay" ).click ->
    $( "#js-overlay-content" ).html(contact_text)

  $( "#tos-overlay" ).click ->
    $( "#js-overlay-content" ).html(tos_text)

  $( "#faq-overlay" ).click ->
    $( "#js-overlay-content" ).html(faq_text)

  $( "#about-overlay" ).click ->
    $( "#js-overlay-content" ).html(about_text)

$(document).ready(ready)
$(document).on('page:load', ready)