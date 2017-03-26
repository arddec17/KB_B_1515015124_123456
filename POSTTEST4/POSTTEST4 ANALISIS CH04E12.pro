/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: CH04E12.PRO
 Purpose: 
 Written by: PDC
 Modifyed by: Eugene Akimov
 Comments: 
******************************************************************************/

trace
domains
  name,sex,occupation,object,vice,substance = symbol   %menggunakan domain agar tipe data tidak tertukar
  age=integer

predicates
  person(name,age,sex,occupation) - nondeterm (o,o,o,o), nondeterm (i,o,o,i), nondeterm (i,o,i,o)
  had_affair(name,name) - nondeterm (i,i), nondeterm (i,o)
  killed_with(name,object) - determ (i,o)
  killed(name) - procedure (o)
  killer(name) - nondeterm (o)
  motive(vice) - nondeterm (i)
  smeared_in(name,substance) - nondeterm (i,o), nondeterm (i,i)
  owns(name,object) - nondeterm (i,i)
  operates_identically(object,object) - nondeterm (o,i)
  owns_probably(name,object) - nondeterm (i,i)
  suspect(name) - nondeterm (i)

/* * * Facts about the murder * * */
clauses
  person(bert,55,m,carpenter).				%Bert, Allan dan John ketiganya adalah terduga sebagai pembunuh
  person(allan,25,m,football_player).
  person(allan,25,m,butcher).
  person(john,25,m,pickpocket).

  had_affair(barbara,john).	%orang-orang yang menyelingkuhi dan di selingkuhi
  had_affair(barbara,bert).
  had_affair(susan,john).

  killed_with(susan,club).	%susan terbunuh dengan pentungan
  killed(susan).		%susan terbunuh

  motive(money).		%Ini adalah motiv dari pembunuhan
  motive(jealousy).
  motive(righteousness).

  smeared_in(bert,blood).	%bert ternodai darah
  smeared_in(susan,blood).	%susan ternodai darah
  smeared_in(allan,mud).	%allan ternodai lumpur
  smeared_in(john,chocolate).	%john ternodai coklat
  smeared_in(barbara,chocolate).%barbare ternodai coklat

  owns(bert,wooden_leg).	%bert memiliki kaki palsu
  owns(john,pistol).		%john memiliki pistol

/* * * Background knowledge * * */

  operates_identically(wooden_leg, club).		%alat yang cara kerjanya mirip dengan senjata penyebab susan terbunuh
  operates_identically(bar, club).
  operates_identically(pair_of_scissors, knife).
  operates_identically(football_boot, club).

  owns_probably(X,football_boot):-			% sepatu bole kemungkinan milik X jika X adalah orang yang memiliki pekerjaan sebagai pemain sepak bola
	person(X,_,_,football_player).
	
  owns_probably(X,pair_of_scissors):-			% gunting kemungkinan milik X jika x adalah orang yang memiliki pekerjaan sebagai pekerja salon
	person(X,_,_,hairdresser).
  owns_probably(X,Object):-
	owns(X,Object).

/* * * * * * * * * * * * * * * * * * * * * * *
 * Suspect all those who own a weapon with   *
 * which Susan could have been killed.       *
 * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-						% X dicurigai Jika siti terbunuh dengan senjata dan benda memiliki cara kerja mirip senjata dan benda kemungkinan milik X
	killed_with(susan,Weapon) ,
	operates_identically(Object,Weapon) ,
	owns_probably(X,Object).
	
	/* Proses unifikasi pada klausa ini memiliki 3 syarat yang harus dipenuhi, dengan proses sebagai berikut
   => tracking pertama
              - syarat pertama "susan terbunuh dengan senjata" berdasarkan hasil unifikasi ditemukan fakta susan terbunuh dengan "PENTUNGAN"
              - syarat kedua "benda cara kerja mirip senjata" berdasarkan hasil unifikasi ditemukan fakta "kaki palsu cara kerja mirip pentungan" fakta ini benar dan sama dengan syarat sebelumnya
              - syarat ketiga "benda kemungkinan milik X" berdasarkan hasil unifikasi ditemukan fakta kaki palsu kemungkinan milik bert.
              - ketiga syarat terpenuhi dan mendapatkan solusi bert dicurigai
   => backtracking pertama
              - syarat pertama "susan terbunuh dengan senjata" berdasarkan hasil unifikasi ditemukan fakta susan terbunuh dengan "PENTUNGAN"
              - syarat kedua "benda cara kerja mirip senjata" berdasarkan hasil unifikasi ditemukan fakta berikutnya "balok cara kerja mirip pentungan" fakta ini benar dan sama dengan syarat sebelumnya
              - syarat ketiga "benda kemungkinan milik X" berdasarkan hasil unifikasi tidak ditemukan fakta mengenai kepemilikan balok
              - ketiga syarat ada yang tidak terpenuhi maka tidak ada solusi pada backtracking ini
   => backracking kedua
              - syarat pertama "susan terbunuh dengan senjata" berdasarkan hasil unifikasi ditemukan fakta susan terbunuh dengan "PENTUNGAN"
              - syarat kedua "benda cara kerja mirip senjata" berdasarkan hasil unifikasi ditemukan fakta berikutnya "gunting cara kerja mirip pisau" fakta ini tidak sama dengan syarat sebelumnya
              - syarat ketiga "benda kemungkinan milik X" berdasarkan hasil unifikasi tidak ditemukan fakta mengenai kepemilikan gunting
              - ketiga syarat ada yang tidak terpenuhi maka tidak ada solusi pada backtracking ini
   => backracking ketiga
              - syarat pertama "susan terbunuh dengan senjata" berdasarkan hasil unifikasi ditemukan fakta susan terbunuh dengan "PENTUNGAN"
              - syarat kedua "benda cara kerja mirip senjata" berdasarkan hasil unifikasi ditemukan fakta berikutnya "sepatu bola cara kerja mirip pentungan" fakta ini benar dan sama dengan syarat sebelumnya
              - syarat ketiga "benda kemungkinan milik X" berdasarkan hasil unifikasi ditemukan fakta berikutnya sepatu bola kemungkinan milik allan
              - ketiga syarat terpenuhi maka ditemukan solusi pada backtracking ini allan dicurigai

 JADI PADA KLAUSA INI DIDAPATKAN 2 SOLUSI YANG DICURIGAI ADALAH BERT DAN ALLAN
*/

/* * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect men who have had an affair with Susan.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-			% X dicurigai jika mempunyai motif cemburu dan X adalah male (laki-laki) dan susan selingkuh dengan X
	motive(jealousy),
	person(X,_,m,_),
	had_affair(susan,X).
	
	/*
 Proses unifikasi pada klausa ini mempunyai 3 syarat yang harus dipenuhi,dengan proses sabagai berikut:
 => tracking pertama
             - syarat pertama "motif cemburu" berdasarkan hasil unifikasi ditemukan fakta tersebut.
             - syarat kedua "orang X dengan jender m" orang dengan jender m(laki-laki) berdasarkan hasil unifikasi ditemukan fakta bert orang dengan jender m.
             - syarat yang ketiga "susan selingkuh dengan X" tidak ditemukan fakta mengenai hal ini.
             - ketiga syarat ada yang tidak terpenuhi maka tracking ini tidak menemukan solusi.
 => backtracking pertama
             - syarat pertama "motif cemburu" berdasarkan hasil unifikasi ditemukan fakta tersebut.
             - syarat kedua "orang X dengan jender m" orang dengan jender m(laki-laki) berdasarkan hasil unifikasi ditemukan fakta allan orang dengan jender m.
             - syarat yang ketiga "susan selingkuh dengan X" tidak ditemukan fakta mengenai hal ini.
             - ketiga syarat ada yang tidak terpenuhi maka backtracking ini tidak menemukan solusi.
 => backtracking kedua
             - syarat pertama "motif cemburu" berdasarkan hasil unifikasi ditemukan fakta tersebut.
             - syarat kedua "orang X dengan jender m" orang dengan jender m(laki-laki) berdasarkan hasil unifikasi ditemukan fakta allan orang dengan jender m.
             - syarat yang ketiga "susan selingkuh dengan X" tidak ditemukan fakta mengenai hal ini.
             - ketiga syarat ada yang tidak terpenuhi maka backtracking ini tidak menemukan solusi. 
 => backtracking ketiga
             - syarat pertama "motif cemburu" berdasarkan hasil unifikasi ditemukan fakta tersebut.
             - syarat kedua "orang X dengan jender m" orang dengan jender m(laki-laki) berdasarkan hasil unifikasi ditemukan fakta john orang dengan jender m.
             - syarat yang ketiga "susan selingkuh dengan X" berdasarkan unifikasi ditemukan fakta yang ada susan selingkuh dengan john.
             - ketiga syarat maka backtracking ini tidak solusi.            

 JADI PADA KLAUSA INI DIDAPATKAN 1 SOLUSI YANG  DICURIGAI ADALAH JOHN
*/

/* * * * * * * * * * * * * * * * * * * * *
 * Suspect females who have had an       *
 * affair with someone that Susan knew.  *
 * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-				%X dicurigai jika mempunyai motif cemburu dan X adalah Female (perempuan) dan X selingkuh dengan seorang laki-laki dan susan selingkuh dengan laki-laki tersebut
	motive(jealousy),
	person(X,_,f,_),
	had_affair(X,Man),
	had_affair(susan,Man).
	
	/*
 Proses unifikasi pada klausa ini mempunyai 4 syarat yang harus dipenuhi
 => tracking pertama
            - syarat pertama "motif cemburu" berdasarkan hasil unifikasi ditemukan fakta tersebut.
            - syarat kedua "orang X dengan jender f(perempuan" berdasarkan hasil unifikasi tidak ditemukan fakta tersebut.
            - syarat ketiga "X selingkuh dengan laki-laki" berdasarkan hasil unifikasi tidak ditemukan fakta tersebut.
            - syarat keempat "susan selingkuh dengan laki-laki" berdasarkan hasil unifikasi tidak ditemukan fakta tersebut.
            - banyak syarat yang tidak terpenuhi, tracking tidak menemukan solusi.
 JADI PADA KLAUSA INI TIDAK DITEMUKAN HASIL
*/

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect pickpockets whose motive could be money.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-			% X dicurigai mempunyai motif uang dan X adalah pencopet
	motive(money),
	person(X,_,_,pickpocket).
	
	/*
 Proses unifikasi pada klausa ini memiliki 2 syarat yang harus dipenuhi,
 => tracking pertama
           - syarat pertama "motif uang" berdasarkan hasil unifikasi ditemukan fakta tersebut.
           - syarat kedua "orang x dengan pekerjaan pencopet" berdasarkan hasil unifikasi ditemukan fakta orang dengan nama John dengan pekerjaan pencopet
           - kedua syarat terpenuhi dan didapatkan hasil solusi dari tracking ini
 JADI PADA KLAUSA INI DIPEROLEH 1 SOLUSI YAITU JOHN
*/

  killer(Killer):-					%/* Pembunuhnya adalah pembunuh jika Pembunuh adalah orang dan terbunuh adalah terbunuh dan bukan bunuh diri dan Pembunuh dicurigai dan pembunuh ternodai oleh zat dan yang terbunuh ternodai oleh zat yang sama dengan pembunuh */
	person(Killer,_,_,_),
	killed(Killed),
	Killed <> Killer, /* It is not a suicide */
	suspect(Killer),
	smeared_in(Killer,Goo),
	smeared_in(Killed,Goo).
	
	/*
 Proses unifikasi pada tahap ini terdapat 6 syarat yang harus terpenuhi, dengan proses sebagai berikut:
 => tracking pertama, 
             pada syarat ditemukan fakta "orang dengan nama bert", berhasil dan 
             lanjut ke syarat kedua "yang terbunuh adalah susan" fakta ditemukan dan
             lanjut ke syarat berikutnya "bert bukan susan" fakta ini benar, 
             lanjut ke syarat berikutnya "bert dicurigai" fakta ini benar pada unifikasi sebelumnya,
             lanjut  ke syarat "bert ternodai zat" berdasarkan fakta yang ada bert ternodai oleh "darah"
             lanjut ke syarat "susan ternodai oleh zat" berdasarkan fakta yang ada susan ternodai oleh "darah" 
             berdasarkan syarat yang ada bert dan susan ternodai oleh zat yang sama maka bert memenuhi syarat sebagai pembunuh, 
             lalu prolog akan melalukan backtracking untuk mencari hasil solusi yang lainya
 => backtracking pertama
             pada syarat ditemukan fakta "orang dengan nama allan", berhasil dan 
             lanjut ke syarat kedua "yang terbunuh adalah susan" fakta ditemukan dan
             lanjut ke syarat berikutnya "allan bukan susan" fakta ini benar, 
             lanjut ke syarat berikutnya "allan dicurigai" fakta ini benar pada unifikasi sebelumnya,
             lanjut  ke syarat "allan ternodai zat" berdasarkan fakta yang ada allan ternodai oleh "lumpur"
             lanjut ke syarat "susan ternodai oleh zat" berdasarkan fakta yang ada susan ternodai oleh "darah" 
             berdasarkan syarat yang ada allan dan susan TIDAK ternodai oleh zat yang sama maka aldi tidak memenuhi syarat sebagai pembunuh
             lalu prolog akan melakukan backtracking lagi untuk solusi lainnya
 => backtracking kedua
              pada syarat ditemukan fakta "orang dengan nama allan", berhasil dan 
             lanjut ke syarat kedua "yang terbunuh adalah susan" fakta ditemukan dan
             lanjut ke syarat berikutnya "allan bukan susan" fakta ini benar, 
             lanjut ke syarat berikutnya "allan dicurigai" fakta ini benar pada unifikasi sebelumnya,
             lanjut  ke syarat "allan ternodai zat" berdasarkan fakta yang ada allan ternodai oleh "lumpur"
             lanjut ke syarat "susan ternodai oleh zat" berdasarkan fakta yang ada susan ternodai oleh "darah" 
             berdasarkan syarat yang ada allan dan susan TIDAK ternodai oleh zat yang sama maka aldi tidak memenuhi syarat sebagai pembunuh
             lalu prolog akan melakukan backtracking lagi untuk solusi lainnya
 => backtracking ketiga
             pada syarat ditemukan fakta "orang dengan nama john", berhasil dan 
             lanjut ke syarat kedua "yang terbunuh adalah susan" fakta ditemukan dan
             lanjut ke syarat berikutnya "john bukan susan" fakta ini benar, 
             lanjut ke syarat berikutnya "john dicurigai" fakta ini benar pada unifikasi sebelumnya,
             lanjut  ke syarat "john ternodai zat" berdasarkan fakta yang ada john ternodai oleh "coklat"
             lanjut ke syarat "susan ternodai oleh zat" berdasarkan fakta yang ada susan ternodai oleh "darah" 
             berdasarkan syarat yang ada john dan susan TIDAK ternodai oleh zat yang sama maka john tidak memenuhi syarat sebagai pembunuh

 JADI PADA KLAUSA INI DIDAPATKAN 1 SOLUSI PEMBUNUH ADALAH BERT
*/

goal
  killer(X).		% X adalah pembunuh
/*
 Proses unifikasi pada goal ini mendapatkan 1 predikat pada klausa yang sama dengan hasil pembunuh adalah bert
 JADI PADA GOAL INI DIDAPATKAN HASIL PADA GOAL INI BERT SEBAGAI PEMBUNUH
 */
