data {
  int<lower=0> n; // liczba obserwacji
  int<lower=0> k_production; // liczba predyktorów dla produkcji
  matrix[n, k_production] X_production; // macierz z danymi wejściowymi (temperatura, nasłonecznienie, zachmurzenie, długość dnia)
  vector[n] energy_production; // wektor z danymi rzeczywistymi dla produkcji energii
}

parameters {
  real a_production; // wyraz wolny
  real<lower=0> sigma_production; // odchylenie standardowe dla produkcji energii
  vector[k_production] beta_production; // współczynnik modelu liniowego
}

transformed parameters {
    vector[n] mu_production;
    mu_production = X_production * beta_production + a_production;
}

model {
    a_production ~ normal(16, 5);

    beta_production[1] ~ normal(5, 0.5);
    beta_production[2] ~ normal(-1.75, 0.3);
    beta_production[3] ~ normal(3, 0.4);

    sigma_production ~ exponential(15);

    // Likelihood
    energy_production ~ normal(mu_production, sigma_production);
}

generated quantities {
  vector[n] y_production_pred_test;
  vector[n] log_lik;

  // Predykcja dla danych testowych
  for (i in 1:n) {
    log_lik[i] = normal_lpdf(energy_production[i] | mu_production[i], sigma_production);
    y_production_pred_test[i] = fmax(normal_rng(mu_production[i], sigma_production),0.1);
  }
}