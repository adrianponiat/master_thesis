data {
  int<lower=0> n; // liczba obserwacji
  int<lower=0> k_consumption; // liczba predyktorów dla zużycia
  matrix[n, k_consumption] X_consumption; // macierz z danymi wejściowymi (dzień tygodnia (BOOL), temperatura)
  vector[n] consumption_energii; // wektor z danymi rzeczywistymi dla zużycia energii
}

parameters {
  real a_consumption; // wyraz wolny
  real<lower=0> sigma_consumption; // odchylenie standardowe dla zużycia energii
  vector[k_consumption] beta_consumption; // współczynnik modelu liniowego
}

transformed parameters {
    vector[n] mu_consumption;
    mu_consumption = a_consumption + X_consumption * beta_consumption;
}

model {
    a_consumption ~ normal(11, 3);

    beta_consumption[1] ~ normal(1, 0.2);
    beta_consumption[2] ~ normal(-1, 0.2);
    beta_consumption[3] ~ normal(-1, 0.2);

    sigma_consumption ~ exponential(0.75);

    // Likelihood
    consumption_energii ~ normal(mu_consumption, sigma_consumption);
}

generated quantities {
  vector[n] y_consumption_pred_test;

  // Predykcja dla danych testowych
  for (i in 1:n) {
    y_consumption_pred_test[i] = normal_rng(mu_consumption[i], sigma_consumption);
  }
}