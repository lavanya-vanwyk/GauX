/// TODO(MVP): Extract the `DriverLocation` entity from the data source layer.
/// Moving this to the domain layer ensures the core business logic does not 
/// depend on how the simulation engine or future WebSockets generate telemetry.