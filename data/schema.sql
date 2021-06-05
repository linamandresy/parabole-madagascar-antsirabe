create table user(
	userid integer primary key,
	f_name text not null,
	l_name text,
	IDCard text not null,
	phone text not null,
	login text not null,
	password text not null,
	admin integer not null default 0 check(
		admin = 0
		or admin = 1
	),
	exported integer not null default 0 check(
		exported = 0
		or exported = 1
	)
);

create table decodername(
	decodernameid integer primary key,
	decodername text not null,
	exported integer not null default 0 check(
		exported = 0
		or exported = 1
	)
);

create table decoder(
	decoderid integer primary key,
	serialnumber text not null,
	decodernameid integer not null,
	userid int not null,
	exported integer not null default 0 check(
		exported = 0
		or exported = 1
	),
	foreign key (userid) references user(userid),
	foreign key (decodernameid) references decodername(decodernameid)
);

create table cardname(
	cardnameid integer primary key,
	cardname text not null,
	exported integer not null default 0 check(
		exported = 0
		or exported = 1
	)
);

create table card(
	cardid integer primary key,
	serialnumber text not null,
	cardnameid integer not null,
	userid int not null,
	exported integer not null default 0 check(
		exported = 0
		or exported = 1
	),
	foreign key (userid) references user(userid),
	foreign key (cardnameid) references cardname(cardnameid)
);

create table bouquet(
	bouquetid integer primary key,
	bouquetname text not null,
	bouquetprice real not null check(bouquetprice > 0),
	exported integer not null default 0 check(
		exported = 0
		or exported = 1
	)
);

create table client(
	clientid integer primary key,
	f_name text not null,
	l_name text null,
	address text not null,
	IDCard text not null,
	long integer not null,
	lat integer not null,
	userid integer not null,
	exported integer not null default 0 check(
		exported = 0
		or exported = 1
	),
	foreign key (userid) references user(userid)
);

create table phone(
	phonenumber text primary key,
	clientid integer not null,
	exported integer not null default 0 check(
		exported = 0
		or exported = 1
	),
	foreign key (clientid) references client(clientid)
);

create table subscription(
	subscriptionid integer primary key,
	clientid integer not null,
	cardid integer not null,
	decoderid integer not null,
	adhesiondate text not null ,
	bouquetid integer not null,
	userid integer not null,
	exported integer not null default 0 check(
		exported = 0
		or exported = 1
	),
	foreign key (clientid) references client(clientid),
	foreign key (cardid) references card(cardid),
	foreign key (decoderid) references decoder(decoderid),
	foreign key (bouquetid) references bouquet(decoderid),
	foreign key (userid) references user(userid)
);

create table renewal(
	renewalid integer primary key,
	subscriptionid integer not null,
	rechargedate text not null,
	amount real not null check(amount>0),
	userid integer not null,
	exported integer not null default 0 check(
		exported = 0
		or exported = 1
	),
	foreign key (subscriptionid) references subscription(subscriptionid),
	foreign key (userid) references user(userid)
);
