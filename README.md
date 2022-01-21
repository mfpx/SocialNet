# SocialNet

This is a Haskell project for ECS713P module by David Stumbra reading for a Master's degree at Queen Mary, University of London.<br>
The repository will become/is public as of 01/02/2022.

## Instructions

1. Clone this repo.
2. Run `stack clean` to make sure `.stack-work` is clean.
3. Run `stack build` to build the project, then `stack run` - or alternatively `stack build && stack run`

## Project explanation

This application utilises Haskell concurrency using the [`parallel-io`](https://hackage.haskell.org/package/parallel-io-0.3.3) package.

It's a good example of concurrency/threading in a functional programming language. Most functional programming languages don't have inbuilt support for features we're used to in OOP languages. Thus, implementing such features from scratch is challenging but interesting.

Another good example where implementing such functionality would be challenging is ANSI C.

## Licence

This project is (un)licenced under [Unlicense](https://unlicense.org/) and is therefore in public domain. See [LICENSE](./LICENSE).