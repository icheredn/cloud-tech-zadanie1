ZADANIE 1

Zbudowanie obrazu: docker build -f Dockerfile -t zadanie1 .

Uruchomienie kontenera: docker run -d -p 5555:8888 --name zad1_cont zadanie1

Sprawdzenie warstw: docker inspect zadanie1 | jq '.[].RootFS'

Labele: docker inspect zadanie1 | jq '.[].Config.Labels'

Logi: docker logs zad1_cont
