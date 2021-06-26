module OrderTaking.DTO.PlaceOrder

import Rango.DataTransfer.JSON.Derive
import Rango.DataTransfer.SQL.Derive

%language ElabReflection
%default total

-- Incoming information
-- From Upstream system

public export
record AddressFormDTO where
  constructor MkAddressFormDTO
  addressLine1 : String
  addressLine2 : String
  addressLine3 : String
  addressLine4 : String
  city         : String
  zipCode      : String

public export
record OrderLineFormDTO where
  constructor MkOrderLineFormDTO
  productCode : String
  quantity    : String

public export
record CustomerFormDTO where
  constructor MkCustomerFormDTO
  firstName    : String
  lastName     : String
  emailAddress : String

public export
record OrderFormDTO where
  constructor MkOrderFormDTO
  customer        : CustomerFormDTO
  shippingAddress : AddressFormDTO
  billingAddress  : AddressFormDTO
  orderLines      : List OrderLineFormDTO

public export
record ProductFormDTO where
  constructor MkProductFormDTO
  productCode : String
  price       : Double
  description : String

%runElab deriveJSON defaultOpts `{{AddressFormDTO}}
%runElab deriveJSON defaultOpts `{{OrderLineFormDTO}}
%runElab deriveJSON defaultOpts `{{CustomerFormDTO}}
%runElab deriveJSON defaultOpts `{{OrderFormDTO}}
%runElab deriveJSON defaultOpts `{{ProductFormDTO}}

-- Outgoing information
-- To Database

public export
Identifier : Type
Identifier = String

public export
record AddressDTO where
  constructor MkAddressDTO
  identifier   : Identifier
  addressLine1 : String
  addressLine2 : (Maybe String)
  addressLine3 : (Maybe String)
  addressLine4 : (Maybe String)
  city         : String
  zipCode      : String

public export
record OrderLineDTO where
  constructor MkOrderLineDTO
  identifier  : Identifier
  productCode : String
  quantity    : String

public export
record PricedOrderLineDTO where
  constructor MkPricedOrderLineDTO
  identifier  : Identifier
  productCode : String
  quantity    : Double
  price       : Double

public export
record CustomerDTO where
  constructor MkCustomerDTO
  identifier   : Identifier
  firstName    : String
  lastName     : String
  emailAddress : String

public export
record OrderDTO where
  constructor MkOrderDTO
  identifier      : Identifier
  customer        : CustomerDTO
  shippingAddress : AddressDTO
  billingAddress  : AddressDTO
  orderLines      : List OrderLineDTO

public export
record PricedOrderDTO where
  constructor MkPricedOrderDTO
  identifier      : Identifier
  customer        : CustomerDTO
  shippingAddress : AddressDTO
  billingAddress  : AddressDTO
  orderLines      : List PricedOrderLineDTO
  amount          : Double

public export
record ProductCodeDTO where
  constructor MkProductCodeDTO
  productCode : String

public export
record ProductDTO where
  constructor MkProductDTO
  productCode : ProductCodeDTO
  price       : Double
  description : String

%runElab deriveJSON defaultOpts `{{AddressDTO}}
%runElab deriveJSON defaultOpts `{{OrderLineDTO}}
%runElab deriveJSON defaultOpts `{{PricedOrderLineDTO}}
%runElab deriveJSON defaultOpts `{{CustomerDTO}}
%runElab deriveJSON defaultOpts `{{OrderDTO}}
%runElab deriveJSON defaultOpts `{{PricedOrderDTO}}

%runElab deriveJSON defaultOpts `{{ProductCodeDTO}}
%runElab deriveJSON defaultOpts `{{ProductDTO}}

-- Outgoing information
-- To Downstream systems

-- public export
-- data PlacedOrderEvent
--   = OrderPlacedEvent         PricedOrder
--   | BillableOrderPlacedEvent BillableOrderPlaced
--   | AcknowledgementSentEvent OrderAcknowledgementSent
--   | InvalidOrderRegistered   InvalidOrder
