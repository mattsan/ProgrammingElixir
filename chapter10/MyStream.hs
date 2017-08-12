module MyStream where

import System.IO

data State a = Start | Next a | Halt a deriving Show

resource sf nf af = \state ->
                      case state of
                        Start -> (Just [], sf)
                        Next rsc -> nf rsc
                        Halt rsc -> (Nothing, af rsc)

to_list itr = to_list' itr (itr Start) []

to_list' itr (Nothing, rsc) acc = acc
  where
    _ = itr (Halt rsc)

to_list' itr (Just values, rsc) acc = to_list' itr (itr (Next rsc)) (acc ++ values)

from1to10 = resource 1 (\x -> if x <= 10 then (Just [x], (x + 1)) else (Nothing, x + 1)) (\x -> x)

resource_ ::  IO b -> (b -> IO (Maybe [a], b)) -> (b -> IO b) -> (State b -> IO (Maybe [a], b))
resource_ sf nf af = \state ->
                      case state of
                        Start -> do
                          rsc <- sf
                          return (Just [], rsc)
                        Next rsc -> do
                          nf rsc
                        Halt rsc -> do
                          af rsc
                          return (Nothing, rsc)

to_list_ itr = do
  next <- itr Start
  to_list_' itr next []

to_list_' itr (Nothing, rsc) acc = return acc
  where
    _ = itr (Halt rsc)

to_list_' itr (Just values, rsc) acc = do
  next <- itr (Next rsc)
  to_list_' itr next (acc ++ values)

sf = openFile "./MyStream.hs" ReadMode

nf handle = do
  eof <- hIsEOF handle
  if eof
    then return (Nothing, handle)
    else do
      line <- hGetLine handle
      return (Just [line], handle)

af handle = do
  hClose handle
  return handle
