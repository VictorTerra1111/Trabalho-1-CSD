# Relógio Digital em FPGA – Nexys A7

## Descrição do Projeto

Este projeto implementa um relógio digital completo utilizando uma placa **Nexys A7** com clock de 100 MHz.
O relógio apresenta **horas, minutos e segundos** em displays de 7 segmentos, com funções de ajuste via botões físicos, incluindo debounce para filtragem de ruído.

O sistema é dividido em módulos independentes:

1. **Clock Divisor (`clock_divisor`)** – Gera um pulso de 1 Hz a partir do clock de 100 MHz.
2. **Contador de Tempo (`counter`)** – Conta segundos, minutos e horas usando o pulso de 1 Hz como enable.
3. **Debounce (`debounce`)** – Filtra os sinais dos botões para evitar múltiplos acionamentos devido a ruído mecânico.
4. **Driver de Display (`dspl_drv_NexysA7`)** – Converte os valores do contador em sinais para os displays de 7 segmentos da placa.

---

## Módulos

### 1. Clock Divisor

* **Entrada:** `clk_100MHz_i`, `reset_i` (ativo baixo)
* **Saída:** `second` – pulso de 1 Hz, 1 ciclo de duração
* **Descrição:** Conta até 100 milhões ciclos do clock principal e gera um pulso a cada segundo.

### 2. Contador de Tempo

* **Entradas:** `clk_100MHz_i`, `reset_i` (ativo baixo), `seconds_pulse_i` (1 Hz)
* **Saídas:** `seconds_o` (0–59), `minutes_o` (0–59), `hours_o` (0–23)
* **Descrição:** Incrementa os segundos a cada pulso de 1 Hz, e atualiza minutos e horas quando necessário. Reseta após 23:59:59.

### 3. Debounce

* **Entradas:** `clk_i`, `rstn_i` (ativo baixo), `key_i`
* **Saída:** `debkey_o` – pulso limpo de um ciclo
* **Descrição:** Máquina de estados que gera um pulso único quando a tecla é pressionada de forma estável. Evita bouncing.

### 4. Top Module

* **Função:** Instancia os módulos `clock_divisor`, `counter`, `debounce` e `dspl_drv_NexysA7`.

---

## Funcionamento do Sistema

1. Após o reset, o relógio inicia em **00:00:00**.
2. O divisor de clock gera pulsos de 1 Hz que incrementam os segundos.
3. Quando `seconds_o` chega a 59, o próximo pulso zera os segundos e incrementa `minutes_o`.
4. Quando `minutes_o` chega a 59, o próximo pulso zera os minutos e incrementa `hours_o`.
5. Quando `hours_o` chega a 23, o próximo pulso zera as horas.
6. Os botões passam por **debounce**.
7. O display apresenta a hora no formato **HH\:MM\:SS**. Durante ajustes, os dígitos em ajuste piscam (500 ms ligado/desligado).
