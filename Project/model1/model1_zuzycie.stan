data {
  int<lower=0> n; // liczba obserwacji
  int<lower=0> k_zuzycie; // liczba predyktorów dla zużycia
  matrix[n, k_zuzycie] X_zuzycie; // macierz z danymi wejściowymi (dzień tygodnia (BOOL), temperatura)
  vector[n] zuzycie_energii; // wektor z danymi rzeczywistymi dla zużycia energii
}

parameters {
  real a_zuzycie; // wyraz wolny
  real<lower=0> sigma_zuzycie; // odchylenie standardowe dla zużycia energii
  vector[k_zuzycie] beta_zuzycie; // współczynnik modelu liniowego
}

transformed parameters {
    vector[n] mu_zuzycie;
    mu_zuzycie = a_zuzycie + X_zuzycie * beta_zuzycie;
}

model {
    a_zuzycie ~ normal(11, 3);

    beta_zuzycie[1] ~ normal(1, 0.2);
    beta_zuzycie[2] ~ normal(-1, 0.2);
    beta_zuzycie[3] ~ normal(-1, 0.2);

    sigma_zuzycie ~ exponential(0.75);

    // Likelihood
    zuzycie_energii ~ normal(mu_zuzycie, sigma_zuzycie);
}

generated quantities {
  vector[n] y_zuzycie_pred_test;

  // Predykcja dla danych testowych
  for (i in 1:n) {
    y_zuzycie_pred_test[i] = normal_rng(mu_zuzycie[i], sigma_zuzycie);
  }
}