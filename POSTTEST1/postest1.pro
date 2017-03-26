predicates
  lamar(symbol,symbol,symbol) - nondeterm (o,o,o)  
  cowok(symbol) - nondeterm (o)
  cewek(symbol) - nondeterm (o)
  bapak(symbol,symbol) -nondeterm (o,i) 
  suka(symbol,symbol) - nondeterm (i,i)
  jomblo(symbol) - nondeterm (i)
  mintarestu(symbol,string) -nondeterm (i,i)
  
clauses
	%lamar sebagai goalnya memiliki syarat berikut 1.ada cowok&cewek 2.sama sama suka 3.single
  lamar(X,Y,Z):-
	cowok(X),
	cewek(Y),
	bapak(Z,Y),
	suka(X,Y),
   	jomblo(Y).
   
	%disini cowok cowoknya
  cowok(ansori).
  cowok(ravi).
  cowok(jambia).
  cowok(pebri).
  	
  	%disini cewek-ceweknya
  cewek(mika).
  cewek(rosa).
  cewek(nia).
  cewek(raisa).
  
  	%disini bapak ceweknya
  bapak(sumanto,safira).
  bapak(ladoyo,salsabila).
  bapak(suprapto,sakera).
  bapak(yakub,raisa).
  
  	%disini daftaryang saling suka
  suka(ansori, safira).
  suka(ravi, raisa).
  suka(jambia, sakera).
  suka(pebri, salsabila).
	
	%disini daftar yang single	
  jomblo(safira).
  jomblo(raisa).
  
  	%disini daftar minta restu
  mintarestu(ansori, "sumanto").
  mintarestu(ravi, "sumanto").
  mintarestu(ansori, "yakub").  
  mintarestu(pebri, "ladoyo").

goal
  lamar(Si,Pengen_lamar,Minta_Restu_Dengan).
