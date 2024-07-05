# Use the official Microsoft .NET SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Copy all the .csproj files and restore any dependencies (via dotnet restore)
COPY ./FleetAPI/FleetAPI.csproj ./FleetAPI/
RUN dotnet restore ./FleetAPI/FleetAPI.csproj

# Copy the rest of the files and build the application
COPY . ./
RUN dotnet publish ./FleetAPI/FleetAPI.csproj -c Release -o out

# Build the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app/out .

# Set the command to run on startup
ENTRYPOINT ["dotnet", "FleetAPI.dll"]
