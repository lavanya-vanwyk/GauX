# Used by `dart_frog build`, which copies it into build/. Build the image
# from there:  cd backend && dart_frog build && docker build -t gaux-api build
#
# Pinned to the Dart version CI uses, so images are reproducible.
FROM dart:3.13 AS build

WORKDIR /app

# Workspace packages (gaux_contracts), copied in by `dart_frog build`
COPY ./.dart_frog_path_dependencies ./.dart_frog_path_dependencies
COPY ./pubspec_overrides.yaml ./pubspec_overrides.yaml

COPY pubspec.* ./
RUN dart pub get

COPY . .
RUN dart pub get --offline
RUN dart compile exe bin/server.dart -o bin/server

# Minimal runtime image: the AOT binary plus the libraries it needs
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/

# Mount a config document here and set REMOTE_CONFIG_PATH to use it
ENV PORT=8080
EXPOSE 8080
CMD ["/app/bin/server"]
