data {
  int<lower=0> n; // liczba obserwacji
  int<lower=0> k_produkcja; // liczba predyktorów dla produkcji
  matrix[n, k_produkcja] X_produkcja; // macierz z danymi wejściowymi (temperatura, nasłonecznienie, zachmurzenie, długość dnia)
  vector[n] produkcja_energii; // wektor z danymi rzeczywistymi dla produkcji energii
}

parameters {
  real a_produkcja; // wyraz wolny
  real<lower=0> sigma_produkcja; // odchylenie standardowe dla produkcji energii
  vector[k_produkcja] beta_produkcja; // współczynnik modelu liniowego
}

transformed parameters {
    vector[n] mu_produkcja;
    mu_produkcja = X_produkcja * beta_produkcja + a_produkcja;
}

model {
    a_produkcja ~ normal(16, 5);

    beta_produkcja[1] ~ normal(3, 0.3);
    beta_produkcja[2] ~ normal(5, 0.5);
    beta_produkcja[3] ~ normal(-1.75, 0.3);
    beta_produkcja[4] ~ normal(3, 0.4);

    sigma_produkcja ~ exponential(15);

    // Likelihood
    produkcja_energii ~ normal(mu_produkcja, sigma_produkcja);
}

generated quantities {
  vector[n] y_produkcja_pred_test;
  vector[n] log_lik;

  // Predykcja dla danych testowych
  for (i in 1:n) {
    log_lik[i] = normal_lpdf(produkcja_energii[i] | mu_produkcja[i], sigma_produkcja);
    y_produkcja_pred_test[i] = normal_rng(mu_produkcja[i], sigma_produkcja);
  }
}