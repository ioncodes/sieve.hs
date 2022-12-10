import Data.Maybe (isNothing, fromJust, isJust, catMaybes)
import System.Environment (getArgs)

initialList :: Int -> [Maybe Int]
initialList n = [Just x | x <- [2..n]]

markMultiples :: (Int -> Bool) -> Int -> [Maybe Int] -> [Maybe Int]
markMultiples _ _ [] = []
markMultiples p n (x:xs)
    | isNothing x     = Nothing : markMultiples p n xs
    | fromJust x <= n = x : markMultiples p n xs
    | p (fromJust x)  = Nothing : markMultiples p n xs
    | otherwise       = x : markMultiples p n xs

nextInt :: Int -> [Maybe Int] -> Int
nextInt n xs = fromJust $ head [x | x <- drop n xs, isJust x]

hasAtleastOne :: (Int -> Bool) -> Int -> [Maybe Int] -> Bool
hasAtleastOne p n xs = any (\x -> isJust x && p (fromJust x)) $ drop n xs

primes :: Int -> [Maybe Int] -> [Maybe Int]
primes n xs =
    if another then primes n' board else board
    where
        board   = markMultiples (\x -> x `mod` n == 0) n xs
        n'      = nextInt (n - 1) board
        another = hasAtleastOne (\x -> x `mod` n' == 0) (n' - 1) board

main :: IO ()
main = do
    args <- getArgs
    let board = initialList (read $ head args)
    let primes' = catMaybes $ primes 2 board
    mapM_ print primes'