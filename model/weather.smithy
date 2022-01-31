namespace example.weather

/// Provides weather forecasts.
/// Triple slash comments attach documentation to shapes.
service Weather {
    version: "2006-03-01",
    resources: [City]
}

resource City {
    identifiers: { cityId: CityId }
}

// "pattern" is a trait.
@pattern("^[A-Za-z0-9 ]+$")
string CityId