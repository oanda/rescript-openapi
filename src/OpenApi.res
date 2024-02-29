/*
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
*/

type map<'a> = Js.Dict.t<'a>

let map = Js.Dict.fromArray

let \"*" = (a1, a2) => (a1, a2)

module Contact = {
  type t = {name: option<string>, url: option<string>, email: option<string>}

  @obj
  external make: (~name: string=?, ~url: string=?, ~email: string=?, unit) => t = ""
}

module Schema = {
  type t
  type additionalProperties

  let apFalse = Obj.magic(false)
  let apSchema = Obj.magic

  @obj
  external string: (
    ~_type: @as("string") _,
    ~description: string=?,
    ~enum: array<string>=?,
    ~default: string=?,
    ~format: [#byte | #binary | #date | #"date-time" | #password]=?,
    unit,
  ) => t = ""

  @obj
  external number: (
    ~_type: @as("number") _,
    ~description: string=?,
    ~minimum: float=?,
    ~maximum: float=?,
    ~exclusiveMinimum: bool=?,
    ~exclusiveMaximum: bool=?,
    unit,
  ) => t = ""

  @obj
  external integer: (
    ~_type: @as("integer") _,
    ~description: string=?,
    ~minimum: int=?,
    ~maximum: int=?,
    ~exclusiveMinimum: bool=?,
    ~exclusiveMaximum: bool=?,
    ~enum: array<int>=?,
    unit,
  ) => t = ""

  @obj
  external array: (~_type: @as("array") _, ~description: string=?, ~items: t, unit) => t = ""

  @obj
  external object: (
    ~_type: @as("object") _,
    ~description: string=?,
    ~properties: map<t>=?,
    ~additionalProperties: additionalProperties=?,
    ~required: array<string>=?,
    unit,
  ) => t = ""

  @obj
  external oneOf: (~oneOf: array<t>, ~description: string=?, unit) => t = ""

  let ref = name => Obj.magic({"$ref": `#/components/schemas/${name}`})
}

module Parameter = {
  type t

  @obj
  external make: (
    ~name: string,
    ~_in: [#query | #header | #path | #cookie],
    ~description: string=?,
    ~required: bool=?,
    ~deprecated: bool=?,
    ~allowEmptyValue: bool=?,
    ~schema: Schema.t,
    unit,
  ) => t = ""

  let ref = name => Obj.magic({"$ref": `#/components/parameters/${name}`})
}

module Header = {
  type t

  @obj
  external make: (
    ~description: string=?,
    ~required: bool=?,
    ~deprecated: bool=?,
    ~allowEmptyValue: bool=?,
    ~style: [#form | #simple]=?,
    ~explode: bool=?,
    ~schema: Schema.t=?,
    unit,
  ) => t = ""

  let ref = name => Obj.magic({"$ref": `#/components/headers/${name}`})
}

module Example = {
  type t = {summary: option<string>, description: option<string>, value: string}

  @obj
  external make: (~summary: string=?, ~description: string=?, ~value: string, unit) => t = ""
}

module MediaType = {
  type t = {
    schema: option<Schema.t>,
    example: option<string>,
    examples: option<map<Example.t>>,
  }

  @obj
  external make: (~schema: Schema.t=?, ~example: string=?, ~examples: map<Example.t>=?, unit) => t =
    ""
}

module Response = {
  type t

  @obj
  external make: (
    ~description: string,
    ~headers: map<Header.t>=?,
    ~content: map<MediaType.t>=?,
    unit,
  ) => t = ""

  let ref = name => Obj.magic({"$ref": `#/components/responses/${name}`})
}

module SecurityScheme = {
  type t

  @obj
  external apiKey: (
    ~_type: @as("apiKey") _,
    ~description: string=?,
    ~name: string,
    ~_in: [#query | #header | #cookie],
    unit,
  ) => t = ""

  let ref = name => Obj.magic({"$ref": `#/components/securitySchemes/${name}`})
}

module License = {
  type t = {name: string, url: option<string>}

  @obj
  external make: (~name: string, ~url: string=?, unit) => t = ""
}

module Info = {
  type t = {
    title: string,
    description: option<string>,
    termsOfService: option<string>,
    contact: option<Contact.t>,
    license: option<License.t>,
    version: string,
  }

  @obj
  external make: (
    ~title: string,
    ~description: string=?,
    ~termsOfService: string=?,
    ~contact: Contact.t=?,
    ~license: License.t=?,
    ~version: string,
    unit,
  ) => t = ""
}

module Server = {
  type t = {url: string, description: option<string>}

  @obj
  external make: (~url: string, ~description: string=?, unit) => t = ""
}

module Operation = {
  type t = {
    tags: option<array<string>>,
    summary: option<string>,
    description: option<string>,
    operationId: option<string>,
    parameters: option<array<Parameter.t>>,
    responses: map<Response.t>,
    deprecated: option<bool>,
    security: option<array<map<array<string>>>>,
  }

  @obj
  external make: (
    ~tags: array<string>=?,
    ~summary: string=?,
    ~description: string=?,
    ~operationId: string=?,
    ~parameters: array<Parameter.t>=?,
    ~responses: map<Response.t>,
    ~deprecated: bool=?,
    ~security: array<map<array<string>>>=?,
    unit,
  ) => t = ""
}

module PathItem = {
  type t

  @obj
  external make: (~summary: string=?, ~description: string=?, ~get: Operation.t=?, unit) => t = ""

  @obj
  external ref: (~\"$ref": string, unit) => t = ""
}

module Components = {
  type t = {
    schemas: option<map<Schema.t>>,
    responses: option<map<Response.t>>,
    parameters: option<map<Parameter.t>>,
    headers: option<map<Header.t>>,
    securitySchemes: option<map<SecurityScheme.t>>,
  }

  @obj
  external make: (
    ~schemas: map<Schema.t>=?,
    ~responses: map<Response.t>=?,
    ~parameters: map<Parameter.t>=?,
    ~headers: map<Header.t>=?,
    ~securitySchemes: map<SecurityScheme.t>=?,
    unit,
  ) => t = ""
}

module Tag = {
  type t = {name: string, description: option<string>}

  @obj
  external make: (~name: string, ~description: string=?, unit) => t = ""
}

type t = {
  openapi: string,
  info: Info.t,
  servers: option<array<Server.t>>,
  paths: map<PathItem.t>,
  components: option<Components.t>,
  tags: option<array<Tag.t>>,
}

@obj
external make: (
  ~openapi: @as("3.0.0") _,
  ~info: Info.t,
  ~servers: array<Server.t>=?,
  ~paths: map<PathItem.t>,
  ~components: Components.t=?,
  ~tags: array<Tag.t>=?,
  unit,
) => t = ""

let print = t => t->Js.Json.stringifyAny->Belt.Option.getExn->Js.log
