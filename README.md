# tstp8 demo

Made with [tstp8](https://github.com/quentinWidlocher/tstp8).

The code is really overkill. It's just to demonstrate how the library works and that it can handle classes, inheritance, events and more.

I've included the `out` directory so you can have a look at `game.ts`, the weird js/d.ts bundle used to transpile to lua and `game.lua`, the code included in the `game.p8` cart that runs.

## Things to look out for

I've remove `@types/node` from `node_modules` since we don't have them, and `tstp8` gives us `console.log` with better typings.
