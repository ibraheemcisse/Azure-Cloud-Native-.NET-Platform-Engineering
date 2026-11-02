FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY ["src/PizzaStore.Api/PizzaStore.Api.csproj", "src/PizzaStore.Api/"]
RUN dotnet restore "src/PizzaStore.Api/PizzaStore.Api.csproj"

COPY . .
WORKDIR /src/src/PizzaStore.Api
RUN dotnet publish "PizzaStore.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

COPY --from=build /app/publish .

RUN mkdir -p /data && chown -R $APP_UID:$APP_UID /data

ENV ASPNETCORE_HTTP_PORTS=8080
EXPOSE 8080

USER $APP_UID

ENTRYPOINT ["dotnet", "PizzaStore.Api.dll"]
