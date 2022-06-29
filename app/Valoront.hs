module Main where

import Control.Monad.Trans.Reader (ReaderT (runReaderT), ask)
import Control.Monad.Trans.Writer (WriterT, execWriterT, runWriterT, tell)
import Data.List
import Helper (MaybeT, liftMaybeT, maybeReadInt, prompt, runMaybeT)
import Module.Item (LogItem (UnknownItem), addNewItem, description, itemId, itemName, parseItem, parseLogItem, restockItem, storage, takeItem)
import Module.Message (LogMessage, makeLogMessage, parseLogMessage)
import System.IO (hFlush, stdout)

runProgram :: [LogItem] -> [LogMessage] -> IO ()
runProgram items messages = do
    putStrLn "\n\n\n=============== Warehouse  Software =============== \n"
    --putStrLn $ replicate 58 '='
    --putStrLn $ showItem items
    --putStrLn "Input SN ONT : " 
    --snONT <- getLine
    putStrLn "a. Cek Validasi ONT"
    putStrLn "b. Ubah Status ONT"
    putStrLn "C. exit \n"
    choice <- prompt "Masukkan Pilihan Anda : "
    case choice of
        "a" -> do
            --putStrLn $ showAllItem items
            noInet <-prompt "\nInput Nomor Internet : "
            let snONT = "11111111" --- diubah ke database
            -- <- stdout
            if noInet == "123123" ---- database
                then putStrLn ("\nNomor "++noInet++ " anda terdaftar diONT dengan SN " ++ snONT)
                --runProgram items messages

            else putStrLn "\nNo Internet Tidak Terdaftar di ONT. Silahkan Input Ulang\n"
            empty <- prompt "Press enter to go back"
            runProgram items messages

        "b" -> do
            noInet <-prompt "\nInput Nomor Internet : "
            let snONT = "11111111"
            putStrLn ("\nNomor "++noInet++ " anda terdaftar diONT dengan SN " ++ snONT ++"Silahkan melakukan pengecekan SN difisik ONT")  
            putStrLn "\na. Sesuai "
            putStrLn "b. Tidak Sesuai\n"
            choice <- prompt "Masukkan Pilihan Anda : "
            hFlush stdout 

        "c" -> do
            putStrLn "Exiting program..."
            putStrLn "Goodbye!"

        _ -> do
            empty <- prompt "Wrong input! Press enter to try again."
            runProgram items messages

showItem :: [LogItem] -> String
showItem items = showItemFunc (length items) (take 2 items)
  where
    showItemFunc count [] = case count of
        0 -> "The item list is currently empty.\n" ++ replicate 58 '='
        1 -> "\n" ++ replicate 58 '='
        2 -> "\n" ++ replicate 58 '='
        _ -> "...and " ++ show (count - 2) ++ " more." ++ "\n" ++ replicate 58 '='
    showItemFunc count (item : rest) =
        "ID: " ++ show (itemId item)
            ++ "\nName: "
            ++ itemName item
            ++ "\nStorage: "
            ++ show (storage item)
            ++ "\nDescription: "
            ++ description item
            ++ "\n"
            ++ replicate 29 '-'
            ++ "\n"
            ++ showItemFunc count rest

showAllItem :: [LogItem] -> String
showAllItem [] = replicate 58 '='
showAllItem (item : rest) =
    "ID: " ++ show (itemId item)
        ++ "\nName: "
        ++ itemName item
        ++ "\nStorage: "
        ++ show (storage item)
        ++ "\nDescription: "
        ++ description item
        ++ "\n"
        ++ replicate 29 '-'
        ++ "\n"
        ++ showAllItem rest

main :: IO ()
main = do
    items <- fmap parseItem (readFile "log/items.log")
    runProgram items []