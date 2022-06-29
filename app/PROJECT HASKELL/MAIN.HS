module Main where

import Lib 
 
prompt :: String -> IO String 
prompt text = do 
    putStr text 
    hFlush stdout 
    getLine 
     
main :: IO () 
main = do 
    putStrLn "\n\n=============== Validasi ONT ===============" 
    putStrLn $ replicate 44 '=' 
    putStrLn "\nSelamat datang, silahkan pilih menu" 
    putStrLn "(a) Cek Ketersediaan ONT  (b) Validasi ONT  (c) Ubah Status ONT  (d) Pendaftaran No Pelanggan"
    choice <-  prompt "Masukkan pilihan anda: "
    case choice of
        "a" -> do
            noOnt <- prompt " Silahkan masukkan No ONT "
            empty <- prompt " Press enter to go back "
            main