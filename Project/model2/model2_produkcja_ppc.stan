data{
    int n;
    matrix[n, 3] X_produkcja;
}


generated quantities {
    vector[3] beta_produkcja;
    beta_produkcja[1] = normal_rng(5, 0.5);
    beta_produkcja[2] = normal_rng(-1.75, 0.3);
    beta_produkcja[3] = normal_rng(3, 0.4);

    real alpha = normal_rng(16, 5);

    real sigma_produkcja = exponential_rng(15);

    real y_gen[n] = normal_rng(alpha + X_produkcja * beta_produkcja, sigma_produkcja);

}
