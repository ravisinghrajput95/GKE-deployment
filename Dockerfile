FROM 16-alpine3.11
ENV NODE_ENV="production"

# Copy app's source code to the /app directory
COPY /app /app

# The application's directory will be the working directory
WORKDIR /app

# Install Node.js dependencies defined in '/app/packages.json'
RUN npm install

FROM 16-alpine3.11
ENV NODE_ENV="production"
COPY --from=builder /app /app
WORKDIR /app
ENV PORT 5000
EXPOSE 5000

# Start the application
CMD ["npm", "start"]