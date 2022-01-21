FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /app

COPY . ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o publish

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build /app/publish .
#ENTRYPOINT ["dotnet", "DockerDemo009.dll"]

CMD ASPNETCORE_URLS=http://*:$PORT dotnet DockerizeWithCICD.dll
