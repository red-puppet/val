DROP TABLE IF EXISTS dbversion;

/*** please read COMMENT descriptions for respective columns ***/

CREATE TABLE dbversion (
  id INT(12) NOT NULL AUTO_INCREMENT COMMENT 'Any inconsistency in sequence will show you potential rollbacks',
  ver VARCHAR(15) NOT NULL DEFAULT '1.0.0' COMMENT 'This should be incremented by each patch applied',
  label VARCHAR(150) NULL UNIQUE COMMENT 'Filename reference or textual description',
  md5hash CHAR(32) NULL UNIQUE COMMENT 'Should be unique',
  vcsid VARCHAR(25) NULL COMMENT 'VCS tag id could be shared by many lines/patches',
  applied  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY (ver)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/***
    (1) INSERT below will be repeated in each .xml <sql>
        operation so as a result you should be able to map
        current database build to what is in the VCS.
        So that relation of patch.xml file to [dbversion] is 1:1

    (2) There is a 1 or 0 : n provision for VCS tag as well
        (that is when we start tagging and deploy using tag id).

    (3) Additional provisions for MD5: If you decide to sign patches that
        constitute your version "bump" then you should not have the same patch/es
        applied more than once, hence UNIQUE KEY constraint

    (4) TODO: All .xml files after 1.0.0 (the first consolidated version)
              must have insert into [dbversion]
        TODO: We may need to backup and turn this table into
              an .xml patch itself when we decide to consolidate
              and promote new MAJOR version like e.g. 2.0.0+
***/

INSERT INTO dbversion
(id, ver, label, md5hash, vcsid)
VALUES
  (0, '1.0.0', 'Consolidated DB build end of Sprint 5', NULL, 'git tag id');

/*** pulling the most recently applied patch w. its corresponding version ***/

SELECT *
  FROM dbversion
 ORDER BY `id` DESC
 LIMIT 1;

