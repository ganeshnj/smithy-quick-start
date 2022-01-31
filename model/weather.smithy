namespace example.weather

/// Provides weather forecasts.
/// Triple slash comments attach documentation to shapes.
service Weather {
    version: "2006-03-01",
    resources: [City]
}

resource City {
    identifiers: { cityId: CityId },
    resources: [Forecast]
}

// "pattern" is a trait.
@pattern("^[A-Za-z0-9 ]+$")
string CityId

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