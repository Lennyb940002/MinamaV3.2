-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 10 déc. 2024 à 20:54
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `minima-new`
--

-- --------------------------------------------------------

--
-- Structure de la table `accounting`
--

CREATE TABLE `accounting` (
  `id` int(11) NOT NULL,
  `type` enum('Revenu','Dépense') NOT NULL,
  `source` enum('Vente','Stock','Marketing','URSSAF') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `date` date NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `accounting_overview`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `accounting_overview` (
`total_revenue` decimal(32,2)
,`total_expenses` decimal(32,2)
,`total_profit` decimal(32,2)
);

-- --------------------------------------------------------

--
-- Structure de la table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `company_name` varchar(100) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `declarations`
--

CREATE TABLE `declarations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `period_start` date NOT NULL,
  `period_end` date NOT NULL,
  `total_sales` decimal(10,2) NOT NULL,
  `total_charges` decimal(10,2) NOT NULL,
  `tax_rate` decimal(5,2) NOT NULL,
  `total_tax` decimal(10,2) NOT NULL,
  `status` enum('Brouillon','En cours','Validé','Rejeté') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `category` enum('Technologie','Mode','Maison') NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` enum('Brouillon','En cours','Validé','Rejeté') NOT NULL,
  `creation_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `selling_price` decimal(10,2) NOT NULL,
  `unit_cost` decimal(10,2) NOT NULL,
  `margin` decimal(10,2) NOT NULL,
  `sale_date` date NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `payment_method` enum('Espèces','Carte','Virement','Chèque') NOT NULL,
  `status` enum('En attente','Confirmé','Annulé') NOT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','manager','employee') DEFAULT 'employee',
  `secret_key` varchar(50) DEFAULT NULL,
  `legal_status` enum('Autoentrepreneur','Microentreprise') NOT NULL,
  `business_duration` enum('Moins d''1 an','1 à 3 ans','3 à 5 ans','Plus de 5 ans') NOT NULL,
  `employee_count` enum('0-1','2-5','6-10','Plus de 10') NOT NULL,
  `tax_regime` enum('12,3%','21%','21,2%','6%') NOT NULL,
  `business_sector` enum('Achat/revente de marchandises','Prestation de services commerciales et artisanales','Prestation de services (libérales ou non)','Location de locaux d''habitation meublés de tourisme classés') NOT NULL,
  `annual_turnover` enum('Moins de 33 200 €','Entre 33 200 € et 72 500 €','Entre 72 500 € et 176 200 €','Plus de 176 200 €') NOT NULL,
  `accounting_management` enum('Avec un expert-comptable','Avec un logiciel comptable','Avec un tableur (Excel ou équivalent)','Aucune solution pour le moment') NOT NULL,
  `primary_objective` enum('Augmenter le chiffre d''affaires','Optimiser les coûts','Développer l''équipe','Digitaliser l''activité') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la vue `accounting_overview`
--
DROP TABLE IF EXISTS `accounting_overview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `accounting_overview`  AS SELECT sum(case when `accounting`.`type` = 'Revenu' then `accounting`.`amount` else 0 end) AS `total_revenue`, sum(case when `accounting`.`type` = 'Dépense' then `accounting`.`amount` else 0 end) AS `total_expenses`, sum(case when `accounting`.`type` = 'Revenu' then `accounting`.`amount` else -`accounting`.`amount` end) AS `total_profit` FROM `accounting` ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `accounting`
--
ALTER TABLE `accounting`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `declarations`
--
ALTER TABLE `declarations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `secret_key` (`secret_key`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `accounting`
--
ALTER TABLE `accounting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `declarations`
--
ALTER TABLE `declarations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `declarations`
--
ALTER TABLE `declarations`
  ADD CONSTRAINT `declarations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
