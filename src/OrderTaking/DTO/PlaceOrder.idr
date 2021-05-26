module OrderTaking.DTO.PlaceOrder

import Rango.DataTransfer.JSON.Derive
import Rango.DataTransfer.SQL.Derive

%language ElabReflection
%default total


public export
record AddressDTO where
  constructor MkAddressDTO
  addressLine1 : String
  addressLine2 : Maybe String
  addressLine3 : Maybe String
  addressLine4 : Maybe String
  city         : String
  zipCode      : String

public export
record OrderLineDTO where
  constructor MkOrderLineDTO
  productCode : String
  quantity    : String

public export
record CustomerInfoDTO where
  constructor MkCustomerInfoDTO
  firstName    : String
  lastName     : String
  emailAddress : String

public export
record OrderFormDTO where
  constructor MkOrderFormDTO
  customerInfo    : CustomerInfoDTO
  shippingAddress : AddressDTO
  billingAddress  : String
  orderLines      : List OrderLineDTO
  amount          : Double

%runElab deriveJSON defaultOpts `{{AddressDTO}}
%runElab deriveJSON defaultOpts `{{OrderLineDTO}}
%runElab deriveJSON defaultOpts `{{CustomerInfoDTO}}
%runElab deriveJSON defaultOpts `{{OrderFormDTO}}

%runElab deriveSQL `{{AddressDTO}}
%runElab deriveSQL `{{OrderLineDTO}}
%runElab deriveSQL `{{CustomerInfoDTO}}
%runElab deriveSQL `{{OrderFormDTO}}
