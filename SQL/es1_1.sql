CREATE TYPE Strutturato AS ENUM(’Ricercatore’, ’Professore Associato’, ’Professore Ordinario’);
CREATE TYPE LavoroProgetto AS ENUM(’Ricerca e Sviluppo’, ’Dimostrazione’, ’Management’, ’Altro’);
CREATE TYPE LavoroNonProgettuale AS ENUMenum (’Didattica’, ’Ricerca’, ’Missione’, ’Incontro Dipartimentale’, ’Incontro
Accademico’, ’Altro’);
CREATE TYPE CausaAssenza AS ENUM(’Chiusura Universitaria’, ’Maternita’, ’Malattia’);

CREATE DOMAIN PosInteger AS INTEGER
	CHECK (VALUE >= 0)

CREATE DOMAIN StringaM as VARCHAR
	CHECK (VAR????)