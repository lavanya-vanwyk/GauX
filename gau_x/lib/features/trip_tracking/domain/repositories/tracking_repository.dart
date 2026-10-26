/// TODO(MVP): Define abstract contracts for driver telemetry and route tracking.
/// Following Dependency Inversion, this interface will allow the presentation 
/// layer to interact with live tracking streams without knowing if the data 
/// comes from the MockSimulation or a live AWS IoT WebSocket stream.