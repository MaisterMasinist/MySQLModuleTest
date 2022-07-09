/*
Adatbázis létrehozása feladat

Készíts adatbázis-táblákat a feladat leírása alapján!
(Magát az adatbázist nem kell létrehoznod.)

Amit be kell adnod:
    - a táblák létrehozásának MySQL utasítása
    - a táblák mezőinek létrehozásához és beállításához szükséges MySQL utasítások

Az utasításokat jelen fájl tartalmazza!

A bónusz feladat megoldása nem kötelező.

Nem futtatható (azaz szintaktikai hibás) SQL utasításokért nem jár pont.
A feladatot részben teljesítő megoldásokért részpontszám jár.
A bónusz feladatnál csak a teljesen helyes megoldásért jár pont.

A feladat leírása törölhető.

Jó munkát!
*/

/*
Adatbázis-táblák létrehozása (20 pont)

Az általad létrehozott adatbázist egy üzenetküldő alkalmazáshoz szeretnénk használni.
Az alkalmazásban a felhasználók regisztrálás után tudnak üzenetet küldeni szintén regisztrált felhasználóknak,
valamint a kapott üzenetekre válaszolhatnak.
Nincs lehetőség több címzett megadására - azaz egy üzenetet csak egy felhasználó részére lehet küldeni.

Az adatbázisnak képesnek kell lennie a következő adatok tárolására:
    1. regisztrált felhasználók adatai
        - kötelező adatok: név, email-cím, jelszó, aktív felhasználó-e, a regisztrálás időpontja
    2. a regisztrált felhasználók által egymásnak küldött üzenetek adatai
        - kötelező adatok: küldő, címzett, üzenet szövege, az üzenet küldésének időpontja,
          továbbá ha az üzenet egy korábban kapottra válasz, akkor hivatkozás a megválaszolt üzenetre

Kritériumok az adatbázissal kapcsolatban:
    - legalább kettő, legfeljebb négy táblát tartalmazzon
    - legyen legalább egy kapcsolat a létrehozott táblák között (idegen kulccsal)
      (egy tábla saját magával is kapcsolódhat)
    - a fent leírt adatokon kívül más adatokat is tárolhat, de egy táblán legfeljebb 8 mező lehet
    - az adatbázis, a táblák és a mezők elnevezése rajtad áll, azonban használj angol megnevezéseket, méghozzá következetesen
      (ha az egyik táblában camel-case szerinti mező-neveket adtál, akkor a másik táblában is tégy úgy)

*/

CREATE TABLE `modulzaro`.`user_data` (`id` INT NOT NULL AUTO_INCREMENT , `name` VARCHAR(100) NOT NULL , `email` VARCHAR(100) NOT NULL , `password` VARCHAR(100) NOT NULL , `active` BOOLEAN NOT NULL , `date` DATE NOT NULL DEFAULT CURRENT_TIMESTAMP , PRIMARY KEY (`id`, `email`), UNIQUE (`email`)) ENGINE = InnoDB;
CREATE TABLE `modulzaro`.`messages` (`id` INT NOT NULL AUTO_INCREMENT , `from_name` VARCHAR(100) NOT NULL , `to_name` VARCHAR(100) NOT NULL , `message` TEXT NOT NULL , `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `reply` INT NULL , PRIMARY KEY (`id`), INDEX (`reply`)) ENGINE = InnoDB;
CREATE TABLE `modulzaro`.`user_messages` (`messages_id` INT NOT NULL , `from_user_email` VARCHAR(100) NOT NULL , `to_user_email` VARCHAR(100) NOT NULL , PRIMARY KEY (`messages_id`, `from_user_email`, `to_user_email`), INDEX `user_data.email` (`from_user_email`, `to_user_email`), FOREIGN KEY (`messages_id`) REFERENCES `messages`(`id`), FOREIGN KEY (`from_user_email`) REFERENCES `user_data`(`email`), FOREIGN KEY (`to_user_email`) REFERENCES `user_data`(`email`)) ENGINE = InnoDB;
-- ---------------------------------------------------------------------------------------------------------------------

/*
Bónusz feladat (5 pont)

Adj hozzá adatokat mindegyik táblához!
(Az adatoknak nem kell valósnak lenniük. Egy felhasználói email-cím lehet például: 'valami@valami.va')

*/

INSERT INTO `user_data` (`name`, `email`, `password`, `active`) VALUES ('joska', 'joska@joska.hu', 'joska1234', 1);
INSERT INTO `user_data` (`name`, `email`, `password`, `active`) VALUES ('pista', 'pista@pista.hu', 'pista1234', 0);
INSERT INTO `user_data` (`name`, `email`, `password`, `active`) VALUES ('feri', 'feri@feri.hu', 'feri1234', 1);

INSERT INTO `messages`(`from_name`, `to_name`, `message`) VALUES ('joska','pista','hello');
INSERT INTO `messages`(`from_name`, `to_name`, `message`, `reply`) VALUES ('pista','joska','szia', 1);
INSERT INTO `messages`(`from_name`, `to_name`, `message`) VALUES ('feri','pista','szevasz');

INSERT INTO `user_messages`(`messages_id`, `from_user_email`, `to_user_email`) VALUES (1,'joska@joska.hu','pista@pista.hu');
INSERT INTO `user_messages`(`messages_id`, `from_user_email`, `to_user_email`) VALUES (2,'pista@pista.hu','joska@joska.hu');
INSERT INTO `user_messages`(`messages_id`, `from_user_email`, `to_user_email`) VALUES (3,'feri@feri.hu','pista@pista.hu');