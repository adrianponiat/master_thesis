data{
    int n;
    matrix[n, 4] X_production;
}

generated quantities {
    vector[4] beta_production;
    beta_production[1] = normal_rng(3, 0.3);
    beta_production[2] = normal_rng(5, 0.5);
    beta_production[3] = normal_rng(-1.75, 0.3);
    beta_production[4] = normal_rng(3, 0.4);

    real alpha = normal_rng(16, 5);

    real sigma_production = exponential_rng(15);

    real y_gen[n] = normal_rng(alpha + X_production * beta_production, sigma_production);
}
