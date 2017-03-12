PREDICATES

nondeterm anak(symbol,symbol).
nondeterm istri(symbol,symbol).
nondeterm pria(symbol).
nondeterm wanita(symbol).
nondeterm usia(symbol,integer).
nondeterm cucu(symbol,symbol) - (o,i).
nondeterm ibu(symbol,symbol) - (o,i).
nondeterm adik(symbol,symbol) - (o,i).
nondeterm kakek(symbol,symbol) - (o,i).

CLAUSES
	anak(jhon, james).
	anak(james, peter).
	anak(sue, ann).
	
	
	istri(ann, james).
	istri(mary, peter).
	
	
	
	pria(jhon).
	pria(james).
	pria(peter).
	
	wanita(mary).
	wanita(sue).
	wanita(ann).
	
	usia(jhon, 10).
	usia(sue, 13).
	
	cucu(X,Y):- anak(X,Z),anak(Z,Y).
	
	ibu(X,Z):- wanita(X),
		istri(X,Y),
		anak(Z,Y).
		
	adik(X,Y):- usia(X,10),usia(Y,13).
	kakek(X,Y):- pria(X),
		     anak(Y,Z),
		     anak(Z,X).
		     
GOAL
cucu(Siapa_cucu ,peter);
ibu(Siapa_ibu, jhon);
adik(Siapa_adik, sue);
kakek(Siapa_kakek, jhon).
