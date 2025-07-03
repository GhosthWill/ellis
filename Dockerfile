# 1. Imagem Base: Use uma imagem oficial do Python como imagem pai.
# O readme.md sugere Python 3.10+. python:3.10-slim é uma boa escolha para uma imagem pequena e estável.
FROM python:3.10-slim

# 2. Diretório de Trabalho: Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 3. Copiar e Instalar Dependências: Copia o arquivo de dependências primeiro para aproveitar o cache de camadas do Docker.
# Se as dependências não mudarem, esta camada não será reconstruída.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copiar Código da Aplicação: Copia o restante do código-fonte da sua aplicação.
COPY . .

# 5. Expor a Porta: Expõe a porta em que o aplicativo é executado. O padrão do Uvicorn é 8000.
EXPOSE 8000

# 6. Comando: O comando para executar sua aplicação.
# Use --host 0.0.0.0 para torná-lo acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000",  "--reload"]