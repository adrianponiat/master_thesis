data{
    int n;
    matrix[n, 3] X_consumption;
}

generated quantities {
    vector[3] beta_consumption;
    beta_consumption[1] = normal_rng(1, 0.2);
    beta_consumption[2] = normal_rng(-1, 0.2);
    beta_consumption[3] = normal_rng(-1, 0.2);

    real alpha = normal_rng(11, 3);

    real sigma_consumption = exponential_rng(0.75);

    real y_gen[n] = normal_rng(alpha + X_consumption * beta_consumption, sigma_consumption);
}
