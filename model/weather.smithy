namespace example.weather

/// Provides weather forecasts.
/// Triple slash comments attach documentation to shapes.
service Weather {
    version: "2006-03-01",
    resources: [City]
}

resource City {
    identifiers: { cityId: CityId },
    read: GetCity,
    resources: [Forecast]
}

// "pattern" is a trait.
@pattern("^[A-Za-z0-9 ]+$")
string CityId

@readonly
operation GetCity {
    input: GetCityInput,
    output: GetCityOutput,
    errors: [NoSuchResource]
}

@input
structure GetCityInput {
    // "cityId" provides the identifier for the resource and
    // has to be marked as required.
    @required
    cityId: CityId
}

@output
structure GetCityOutput {
    // "required" is used on output to indicate if the service
    // will always provide a value for the member.
    @required
    name: String,

    @required
    coordinates: CityCoordinates,
}

structure CityCoordinates {
    @required
    latitude: Float,

    @required
    longitude: Float,
}

// "error" is a trait that is used to specialize
// a structure as an error.
@error("client")
structure NoSuchResource {
    @required
    resourceType: String
}

resource Forecast {
    identifiers: { cityId: CityId },
    read: GetForecast,
}

@readonly
operation GetForecast {
    input: GetForecastInput,
    output: GetForecastOutput
}

// "cityId" provides the only identifier for the resource since
// a Forecast doesn't have its own.
@input
structure GetForecastInput {
    @required
    cityId: CityId,
}

@output
structure GetForecastOutput {
    chanceOfRain: Float
}