## rescript-openapi

Copyright 2024 OANDA Corporation

This file is part of rescript-openapi.

rescript-openapi is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

rescript-openapi is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
rescript-openapi. If not, see <https://www.gnu.org/licenses/>.

## What

This is a helper library for writing well-formed OpenAPI 3 spec documents. It
helps you create a valid spec document as a JavaScript object, then renders that
as a JSON object and prints it to standard output. You can write the spec and
print it using any standard JavaScript runtime.

## Example

```rescript
open! OpenApi // Because we override the '*' operator

let () = print(
  make(
    ~info=...,
    ~servers=[...],
    ~paths=map([
      "/todos" * PathItem.make(...),
      "/todo" * PathItem.make(...),
    ]),
    ~components=...,
    ~tags=[...],
    (),
  ),
)
```

You can run this, redirect the printed JSON to a file eg `my_api.json`, and use
that as input to any off-the-shelf OpenAPI spec rendering tool (personally I
like [RapiDoc](https://rapidocweb.com/)).

## Why

The library is designed to enforce the rules of a correct OpenAPI spec document.
Run ReScript in watch mode while you write the spec, and it will continuously
check for errors.

It also allows you to take advantage of the full power of the ReScript language
for abstraction and other conveniences, like string interpolation. You can
define reusable pieces of code in a way that can work well with the references
allowed in OpenAPI but go even beyond them for maintainability.

