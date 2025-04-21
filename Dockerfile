# -------- BUILD STAGE --------
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Copy project file and restore
COPY *.csproj ./
RUN dotnet restore

# Copy toàn bộ source code và build
COPY . ./
RUN dotnet publish -c Release -o out

# -------- RUNTIME STAGE --------
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT ["dotnet", "Photoez.dll"]
