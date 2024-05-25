data{
    int n;
    matrix[n, 3] X_zuzycie;
}

generated quantities {
    vector[3] beta_zuzycie;
    beta_zuzycie[1] = normal_rng(1, 0.2);
    beta_zuzycie[2] = normal_rng(-1, 0.2);
    beta_zuzycie[3] = normal_rng(-1, 0.2);

    real alpha = normal_rng(11, 3);

    real sigma_zuzycie = exponential_rng(0.75);

    real y_gen[n] = normal_rng(alpha + X_zuzycie * beta_zuzycie, sigma_zuzycie);
}
