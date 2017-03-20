
predicates
	nondeterm mengambil(symbol,string,string)
	nondeterm matakuliah(string)
	nondeterm mahasiswa(symbol)
	
clauses

	mahasiswa(irfan).
	mahasiswa(komeng).
	mahasiswa(dati).
	mahasiswa(fatimah).
	mahasiswa(maspion).
	mahasiswa(ricky).
	mahasiswa(embang).
	mahasiswa(malmin).
	mahasiswa(vina).
	mahasiswa(sondang).
	
	mengambil(irfan,"Intelejensi Buatan","A").
	mengambil(komeng,"Intelejensi Buatan","D").
	mengambil(dati,"Intelejensi Buatan","C").
	mengambil(fatimah,"Intelejensi Buatan","B").
	mengambil(maspion,"Intelejensi Buatan","C").

	mengambil(ricky,"PDE","A").
	mengambil(embang,"PDE","A").
	mengambil(malmin,"PDE","A").
	mengambil(vina,"PDE","A").
	mengambil(sondang,"PDE","A").

	mengambil(sondang,"SO","D").
	mengambil(sondang,"SO","E").
	mengambil(sondang,"SO","B").
	mengambil(sondang,"SO","A").
	mengambil(sondang,"SO","A").
	
	matakuliah("Intelejensi Buatan").
	matakuliah("PDE").
	matakuliah("SOS").
goal
	write("Nama Mahasiswa Yang Mengikut Mata Kuliah Intelejensi Buatan :"),nl,
	write(),nl,
	mengambil(Mahasiswa,"Intelejensi Buatan",_);
	write(),nl,
	
	write("Nama Mahasiswa Yang Lulus :"),nl,
	write(),nl,
	mengambil(Mahasiswa,_,Nilai),Nilai<"D";
	write(),nl,
	
	write("Nama Mahasiswa Yang Tidak Lulus"),nl,
	write(),nl,
	mengambil(Mahasiswa,_,Nilai),Nilai>="D";
	write(),nl,
	
	write("Seluruh Nama Matakuliah Yang Diajarkan :"),nl,
	write(),nl,
	matakuliah(Matakuliah);
	write(),nl,
	
	write("Seluruh Nama Mahasiswa Yang Ada"),nl,
	write(),nl,
	mahasiswa(Nama_Mahasiswa).
	