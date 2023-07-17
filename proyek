# Mengimpor Modul
import pandas

# Mengimpor Modul untuk pembuatan tabel
from tabulate import tabulate

# Fungsi untuk menyimpan atribut dan metode yang diperlukan dalam transaksi
class Transaction:
    def __init__(self):


       """
       Parameter:
       dict_transaksi (dict) = untuk menyimpan data transaksi (dict) 
       transaksi_valid = untuk memeriksa apakah data yang dimasukkan dalam dict_transaksi sudah benar. 

       """

       self.dict_transaksi = dict()
       self.transaksi_valid = True
    
    # Fungsi untuk menambahkan item ke dalam dictionary transaksi.
    def add_item(self, nama, jumlah, harga):

        """
        Parameter:
        nama_item (String, key) = nama item yang dibeli, key dalam dictionary
        jumlah_item (int) = jumlah item yang dibeli
        harga_item (int) = harga per item
        
        """
        
        # Pengecekkan tipe data
        if type(jumlah)!=int:
            print("Jumlah barang berupa angka!")
        
        elif type(harga)!=int:
            print("Harga barang berupa angka!")
        
        else:
            # memasukkan data ke dalam dict
            dict_add = {nama: [jumlah, harga, jumlah*harga]}
            self.dict_transaksi.update(dict_add)
            print(f"Pesanan yang ditambahkan yaitu {nama} sejumlah {jumlah} item dengan harga Rp {harga}.")
    
    # Fungsi untuk mengubah nama item dalam dictionary yang sudah dimasukkan.
    def update_item_name(self, nama, nama_baru):

        """
        Parameter:
        nama(String) = nama item sebelum diganti, key dari dictionary
        nama_baru (String) = nama baru untuk item, menjadi key baru dari dictionary

        """
            
        key = self.dict_transaksi[nama]
        self.dict_transaksi.pop(nama)
        self.dict_transaksi.update({nama_baru: key})
        
        # Menampilkan data pesanan setelah terdapat perubahan
        self.print_order()
        print(f"Nama item {nama} berubah menjadi {nama_baru}.")
    
    # Fungsi untuk mengubah jumlah item dalam dictionary yang sudah dimasukkan.
    def update_item_qty(self, nama, jumlah_baru):

        """
        Parameter:
        nama (String) = nama item yang ingin diubah jumlahnya, key dari dictionary
        jumlah_baru (int) = jumlah baru dari nama item yang dibeli
        
        """
            
        # Pengecekkan tipe data
        if type(jumlah_baru)!=int:
            print("Jumlah barang berupa angka!")
        
        else:
            # Memasukkan data ke dalam dict
            self.dict_transaksi[nama][0] = jumlah_baru
            self.dict_transaksi[nama][2] = jumlah_baru*self.dict_transaksi[nama][1]
        
            #menampilkan data pesanan setelah terdapat perubahan
            self.print_order()
            print(f"Jumlah item {nama} berubah menjadi {jumlah_baru}.")
    
    # Fungsi untuk mengubah harga item dalam dictionary yang sudah dimasukkan.
    def update_item_price(self, nama, harga_baru):

        """
        Parameter:
        nama (String) = nama item yang ingin diubah harganya, key dari dictionary
        harga_baru (int) = harga baru dari nama item yang dibeli
        
        """

        # Pengecekkan tipe data        
        if type(harga_baru)!=int:
            print("Harga barang berupa angka!")
        
        else: 
            # Memasukkan data ke dalam dict
            self.dict_transaksi[nama][1] = harga_baru
            self.dict_transaksi[nama][2] = harga_baru*self.dict_transaksi[nama][0]
            
            # Menampilkan data pesanan setelah terdapat perubahan
            self.print_order()
            print(f"Harga item {nama} berubah menjadi {harga_baru}.")
    
    # Fungsi untuk menghapus data nama item beserta jumlah dan harganya dari dictionary.
    def delete_item(self, nama):

        """
        Parameter:
        nama (String) = nama item yang ingin dihapus

        """
        
        try:
            self.dict_transaksi.pop(nama)
            print(f"Pesanan {nama} berhasil dihapus.")
            print("")
            self.print_order()
            
        
        except KeyError:
            print(f"tidak ada item {nama} dalam daftar pesanan.")
        
    # Fungsi untuk menghapus semua data pesanan dalam dictionary.
    def reset_transaction(self):
        
        self.dict_transaksi = self.dict_transaksi.clear
        print("Seluruh item telah berhasil dihapus!")
    
    # Fungsi untuk menampilkan semua pesanan dalam dictionary.
    def print_order(self):
        
        try:
            table_transaksi = pandas.DataFrame(self.dict_transaksi).T
            headers = ["Nama Item", "Jumlah Item", "Harga", "Total Harga"]
            print(tabulate(table_transaksi, headers, tablefmt="github"))
        
        except:
            print("tidak terdapat pesanan.")
            
    # Fungsi untuk mengecek dan menampilkan semua pesanan dalam dictionary.        
    def check_order(self):
        
        try:
            # Menampilkan semua pesanan
            table_transaksi = pandas.DataFrame(self.dict_transaksi).T
            headers = ["Nama Item", "Jumlah Item", "Harga", "Total Harga"]
            print(tabulate(table_transaksi, headers, tablefmt="github"))

            # Pengecekan jumlah atau harga
            kolom=0
            while kolom<2:
                for data in table_transaksi[kolom]:
                    if data<=0:
                        self.transaksi_valid = False
                kolom+=1

            if self.transaksi_valid:
                print("Pemesanan sudah benar.")
            else:
                print("Terdapat kesalahan pada saat menginput jumlahata harga item")
        
        except ValueError:
            print("tidak terdapat pesanan.")

    # Fungsi untuk menampilkan semua pesanan dan total belanja        
    def total_price(self):
        
        # Memastikan pesanan yang sudah benar
        self.check_order()

        if self.transaksi_valid:

            # Menghitung total_spending
            total_spending = 0
            for item in self.dict_transaksi:
                total_spending += self.dict_transaksi[item][2] 

            # Pemotongan Harga
            if total_spending>500_000:
                diskon = int(total_spending*0.1)
                total_spending = int(total_spending-diskon)
                print(f"Total belanja Anda saat ini yaitu Rp {total_spending} dengan diskon sebesar Rp. {diskon} atau setara dengan 10%.")        

            elif total_spending>300_000:
                diskon = int(total_spending*0.08)
                total_spending = int(total_spending-diskon)
                print(f"Total belanja Anda saat ini yaitu Rp {total_spending} dengan diskon sebesar Rp. {diskon} atau setara dengan 8%.")

            elif total_spending>200_000:
                diskon = int(total_spending*0.05)
                total_spending = int(total_spending-diskon)
                print(f"Total belanja Anda saat ini yaitu Rp {total_spending} dengan diskon sebesar Rp. {diskon} atau setara dengan 5%.")

            else:
                print(f"Total belanja Anda secara keseluruhan yaitu mencapai Rp {total_spending}.")
        
  
