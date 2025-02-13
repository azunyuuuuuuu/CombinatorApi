ARG VERSION=6.0-alpine

FROM mcr.microsoft.com/dotnet/sdk:$VERSION AS build
WORKDIR /app

COPY ./*.csproj ./
RUN dotnet restore

COPY ./* ./

RUN dotnet publish -c Release -o /out --no-restore


FROM mcr.microsoft.com/dotnet/aspnet:$VERSION AS runtime
WORKDIR /app
COPY --from=build /out ./

ENV Logging__Console__FormatterName=Simple
EXPOSE 80

VOLUME /app/data

ENTRYPOINT ["dotnet", "ApiStuffs.dll"]