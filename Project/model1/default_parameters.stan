data {
  int<lower=0> n; // liczba obserwacji
  int<lower=0> k_zuzycie; // liczba predyktorów dla zużycia
  int<lower=0> k_produkcja; // liczba predyktorów dla produkcji
  matrix[n, k_zuzycie] X_zuzycie; // macierz z danymi wejściowymi (dzień tygodnia (BOOL), temperatura)
  matrix[n, k_produkcja] X_produkcja; // macierz z danymi wejściowymi (temperatura, nasłonecznienie, zachmurzenie, długość dnia)
  vector[n] zuzycie_energii; // wektor z danymi rzeczywistymi dla zużycia energii
  vector[n] produkcja_energii; // wektor z danymi rzeczywistymi dla produkcji energii
//   int<lower=0> n_test; // liczba danych testowych
//   matrix[n_test, 4] X_test; // macierz z danymi testowymi
}

parameters {
  // real a_zuzycie; // współczynnik dla zużycia energii
  // real a_produkcja; // współczynnik dla produkcji energii
  // real b; // wyraz wolny
  // real<lower=0> sigma_zuzycie; // odchylenie standardowe dla zużycia energii
  // real<lower=0> sigma_produkcja; // odchylenie standardowe dla produkcji energii
  // vector<lower=0, upper=1>[k_zuzycie] beta_zuzycie;
  // vector<lower=0, upper=1>[k_produkcja] beta_produkcja;
}

transformed parameters {
    // vector[n] y_zuzycie_pred = exp(a_zuzycie * X[:, 1] + a_zuzycie * X[:, 2] + a_zuzycie * X[:, 3] + a_zuzycie * X[:, 4] + b);
    // vector[n] y_produkcja_pred = exp(a_produkcja * X[:, 1] + a_produkcja * X[:, 2] + a_produkcja * X[:, 3] + a_produkcja * X[:, 4] + b);
    real<lower=0> sigma_zuzycie = 2.706721; // odchylenie standardowe dla zużycia energii
    real<lower=0> sigma_produkcja = 10.70544;

    row_vector<lower=0>[k_zuzycie] beta_zuzycie;
    row_vector[k_produkcja] beta_produkcja;

    beta_zuzycie = [0.9, 0.3];
    vector[n] mu_zuzycie;
    mu_zuzycie = X_zuzycie * beta_zuzycie';

    beta_produkcja = [0.2, 0.06, -0.9, 0.4];
    vector[n] mu_produkcja;
    mu_produkcja = X_produkcja * beta_produkcja';
}

model {
//   vector[n] y_zuzycie_pred;
//   vector[n] y_produkcja_pred;

  // Model regresji z rozkładem normalnym dla zużycia energii
//   for (i in 1:n) {
//     y_zuzycie_pred[i] = normal_rng(a_zuzycie * X[i, 1] + a_zuzycie * X[i, 2] + a_zuzycie * X[i, 3] + a_zuzycie * X[i, 4] + b, sigma_zuzycie);
//   }
  //beta_zuzycie ~ beta(1,1);
  //zuzycie_energii ~ normal(mu_zuzycie, sigma_zuzycie);

  // Model regresji z rozkładem normalnym dla produkcji energii
//   for (i in 1:n) {
//     y_produkcja_pred[i] = normal_rng(a_produkcja * X[i, 1] + a_produkcja * X[i, 2] + a_produkcja * X[i, 3] + a_produkcja * X[i, 4] + b, sigma_produkcja);
//   }
  //beta_produkcja ~ beta(1,1);
  //produkcja_energii ~ normal(mu_produkcja, sigma_produkcja);
}

generated quantities {
  vector[n] y_zuzycie_pred_test;
  vector[n] y_produkcja_pred_test;

  // Predykcja dla danych testowych
  for (i in 1:n) {
    // y_zuzycie_pred_test[i] = normal_rng(a_zuzycie * X[i, 1] + a_zuzycie * X[i, 2] + a_zuzycie * X[i, 3] + a_zuzycie * X[i, 4] + b, sigma_zuzycie);
    // y_produkcja_pred_test[i] = normal_rng(a_produkcja * X[i, 1] + a_produkcja * X[i, 2] + a_produkcja * X[i, 3] + a_produkcja * X[i, 4] + b, sigma_produkcja);
    y_zuzycie_pred_test[i] = normal_rng(mu_zuzycie[i], sigma_zuzycie);
    y_produkcja_pred_test[i] = normal_rng(mu_produkcja[i], sigma_produkcja);
  }
}