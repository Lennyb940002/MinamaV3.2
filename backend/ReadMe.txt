Table : users
Cette table gère les informations des utilisateurs de l'application.

Colonnes :
id : Identifiant unique de l'utilisateur (clé primaire, incrément automatique).
username : Nom d'utilisateur unique (50 caractères max).
first_name : Prénom de l'utilisateur (50 caractères max).
last_name : Nom de famille de l'utilisateur (50 caractères max).
email : Adresse email unique de l'utilisateur (100 caractères max).
password : Mot de passe hashé (255 caractères max).
role : Rôle de l'utilisateur : admin, manager, ou employee (par défaut : employee).
secret_key : Clé secrète pour des usages spécifiques (unique).
Colonnes métier :
legal_status : Statut juridique : Autoentrepreneur ou Microentreprise.
business_duration : Durée d'activité de l'entreprise.
employee_count : Nombre d'employés.
tax_regime : Régime fiscal applicable.
business_sector : Secteur d'activité.
annual_turnover : Chiffre d'affaires annuel.
accounting_management : Mode de gestion comptable.
primary_objective : Objectif principal de l'utilisateur.
created_at : Date de création de l'utilisateur.
Table : sales
Cette table enregistre les informations liées aux ventes réalisées.

Colonnes :
id : Identifiant unique de la vente (clé primaire).
product_id : Référence du produit vendu (clé étrangère vers products).
quantity : Quantité vendue.
selling_price : Prix de vente unitaire.
unit_cost : Coût unitaire du produit.
margin : Marge réalisée.
sale_date : Date de la vente.
customer_id : Identifiant du client (clé étrangère vers customers).
payment_method : Mode de paiement : Espèces, Carte, Virement, ou Chèque.
status : Statut de la vente : En attente, Confirmé, ou Annulé.
notes : Notes supplémentaires.
Table : stocks
Cette table suit les informations relatives aux stocks.

Colonnes :
id : Identifiant unique du stock (clé primaire).
product_id : Référence du produit (clé étrangère vers products).
reference : Référence interne du produit.
quantity : Quantité disponible en stock.
unit_price : Prix unitaire d'achat.
total_price : Valeur totale du stock (calculée).
selling_price : Prix unitaire de vente.
Table : accounting
Cette table centralise les données comptables.

Colonnes :
id : Identifiant unique de l'entrée comptable (clé primaire).
type : Type de transaction : Revenu ou Dépense.
source : Source de la transaction : Vente, Stock, Marketing, ou URSSAF.
amount : Montant de la transaction.
date : Date de l'enregistrement.
description : Description ou commentaire.
Table : declarations
Cette table stocke les déclarations fiscales ou administratives.

Colonnes :
id : Identifiant unique de la déclaration (clé primaire).
user_id : Référence de l'utilisateur ayant soumis la déclaration (clé étrangère vers users).
period_start : Début de la période concernée.
period_end : Fin de la période concernée.
total_sales : Montant total des ventes déclarées.
total_charges : Montant total des charges déclarées.
tax_rate : Taux de taxation applicable.
total_tax : Montant total des taxes.
status : Statut de la déclaration : Brouillon, En cours, Validé, ou Rejeté.
Table : products
Cette table enregistre les produits proposés par l'entreprise.

Colonnes :
id : Identifiant unique du produit (clé primaire).
category : Catégorie du produit : Technologie, Mode, ou Maison.
name : Nom du produit.
status : Statut du produit : Brouillon, En cours, Validé, ou Rejeté.
creation_date : Date de création du produit.
Vues :
sales_overview :
Permet d'avoir une vision globale sur les ventes :

Total des ventes.
Revenu total.
Prix de vente moyen.
Marge totale.
stock_overview :
Fournit un aperçu des stocks :

Nombre total de produits en stock.
Valeur totale des stocks.
Nombre de commandes en attente.
accounting_overview :
Donne une vue comptable synthétique :

Revenus totaux.
Dépenses totales.
Résultat net (profit ou perte).