'use client';

import { useState, useMemo } from 'react';

export default function Home() {
  const [from, setFrom] = useState('USD');
  const [to, setTo] = useState('EUR');
  const [amount, setAmount] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [result, setResult] = useState<any>(null);

  const isFormValid = useMemo(() => {
    return from !== to && amount !== '' && parseFloat(amount) > 0;
  }, [from, to, amount]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!isFormValid) return;

    setLoading(true);
    setError('');
    setResult(null);

    try {
      const response = await fetch('http://localhost:3000/api/v1/convert', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          conversion: {
            source: from,
            target: to,
            source_amount: parseFloat(amount),
          },
        }),
      });

      if (!response.ok) {
        throw new Error('Conversion failed');
      }

      const data = await response.json();
      setResult(data);
    } catch (err) {
      setError('Failed to convert currency. Please try again.');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const currencies = [
    { code: "AUD", name: "Australian Dollar" },
    { code: "BGN", name: "Bulgarian Lev" },
    { code: "BRL", name: "Brazilian Real" },
    { code: "CAD", name: "Canadian Dollar" },
    { code: "CHF", name: "Swiss Franc" },
    { code: "CNY", name: "Chinese Renminbi Yuan" },
    { code: "CZK", name: "Czech Koruna" },
    { code: "DKK", name: "Danish Krone" },
    { code: "EUR", name: "Euro" },
    { code: "GBP", name: "British Pound" },
    { code: "HKD", name: "Hong Kong Dollar" },
    { code: "HUF", name: "Hungarian Forint" },
    { code: "IDR", name: "Indonesian Rupiah" },
    { code: "ILS", name: "Israeli New Shekel" },
    { code: "INR", name: "Indian Rupee" },
    { code: "ISK", name: "Icelandic Króna" },
    { code: "JPY", name: "Japanese Yen" },
    { code: "KRW", name: "South Korean Won" },
    { code: "MXN", name: "Mexican Peso" },
    { code: "MYR", name: "Malaysian Ringgit" },
    { code: "NOK", name: "Norwegian Krone" },
    { code: "NZD", name: "New Zealand Dollar" },
    { code: "PHP", name: "Philippine Peso" },
    { code: "PLN", name: "Polish Złoty" },
    { code: "RON", name: "Romanian Leu" },
    { code: "SEK", name: "Swedish Krona" },
    { code: "SGD", name: "Singapore Dollar" },
    { code: "THB", name: "Thai Baht" },
    { code: "TRY", name: "Turkish Lira" },
    { code: "USD", name: "United States Dollar" },
    { code: "ZAR", name: "South African Rand" }
  ];

  return (
    <div className="flex min-h-screen items-center justify-center bg-zinc-50 font-sans dark:bg-black">
      <main className="flex w-full max-w-xl flex-col gap-4 px-6 py-8">
        <div className="text-center">
          <h1 className="text-3xl font-bold tracking-tight text-black dark:text-zinc-50">
            Currency Converter
          </h1>
          <p className="mt-1 text-base text-zinc-600 dark:text-zinc-400">
            Convert between different currencies
          </p>
        </div>

        <form onSubmit={handleSubmit} className="flex flex-col gap-4 rounded-lg border border-zinc-200 bg-white p-6 shadow-sm dark:border-zinc-800 dark:bg-zinc-900">
          <div className="flex flex-col gap-1.5">
            <label htmlFor="from" className="text-sm font-medium text-zinc-700 dark:text-zinc-300">
              From
            </label>
            <select
              id="from"
              name="from"
              value={from}
              onChange={(e) => setFrom(e.target.value)}
              className="rounded-md border border-zinc-300 bg-white px-4 py-2 text-base text-zinc-900 focus:border-zinc-500 focus:outline-none focus:ring-2 focus:ring-zinc-500 dark:border-zinc-700 dark:bg-zinc-800 dark:text-zinc-100"
            >
              {currencies.map((currency) => (
                <option key={currency.code} value={currency.code}>
                  {currency.code} - {currency.name}
                </option>
              ))}
            </select>
          </div>

          <div className="flex flex-col gap-1.5">
            <label htmlFor="to" className="text-sm font-medium text-zinc-700 dark:text-zinc-300">
              To
            </label>
            <select
              id="to"
              name="to"
              value={to}
              onChange={(e) => setTo(e.target.value)}
              className="rounded-md border border-zinc-300 bg-white px-4 py-2 text-base text-zinc-900 focus:border-zinc-500 focus:outline-none focus:ring-2 focus:ring-zinc-500 dark:border-zinc-700 dark:bg-zinc-800 dark:text-zinc-100"
            >
              {currencies.map((currency) => (
                <option key={currency.code} value={currency.code}>
                  {currency.code} - {currency.name}
                </option>
              ))}
            </select>
          </div>

          <div className="flex flex-col gap-1.5">
            <label htmlFor="amount" className="text-sm font-medium text-zinc-700 dark:text-zinc-300">
              Amount
            </label>
            <input
              type="number"
              id="amount"
              name="amount"
              value={amount}
              onChange={(e) => setAmount(e.target.value)}
              placeholder="Enter amount"
              step="0.01"
              min="0"
              className="rounded-md border border-zinc-300 bg-white px-4 py-2 text-base text-zinc-900 focus:border-zinc-500 focus:outline-none focus:ring-2 focus:ring-zinc-500 dark:border-zinc-700 dark:bg-zinc-800 dark:text-zinc-100"
            />
          </div>

          <button
            type="submit"
            disabled={!isFormValid || loading}
            className="mt-2 rounded-md bg-black px-6 py-2.5 text-base font-medium text-white transition-colors hover:bg-zinc-800 disabled:opacity-50 disabled:cursor-not-allowed dark:bg-zinc-50 dark:text-black dark:hover:bg-zinc-200"
          >
            {loading ? 'Converting...' : 'Convert'}
          </button>

          {from === to && (
            <p className="text-sm text-red-600 dark:text-red-400">
              Source and target currencies must be different
            </p>
          )}
        </form>

        {error && (
          <div className="rounded-lg border border-red-200 bg-red-50 p-4 text-red-800 dark:border-red-800 dark:bg-red-900/20 dark:text-red-200">
            {error}
          </div>
        )}

        {result && (
          <div className="rounded-lg border border-zinc-200 bg-white p-6 shadow-sm dark:border-zinc-800 dark:bg-zinc-900">
            <h2 className="mb-4 text-xl font-semibold text-black dark:text-zinc-50">
              Conversion Result
            </h2>
            <div className="space-y-3">
              <div className="flex justify-between">
                <span className="text-zinc-600 dark:text-zinc-400">From:</span>
                <span className="font-medium text-black dark:text-zinc-50">{result.source}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-zinc-600 dark:text-zinc-400">To:</span>
                <span className="font-medium text-black dark:text-zinc-50">{result.target}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-zinc-600 dark:text-zinc-400">Original Amount:</span>
                <span className="font-medium text-black dark:text-zinc-50">{result.source_amount}</span>
              </div>
              <div className="flex justify-between border-t border-zinc-200 pt-3 dark:border-zinc-700">
                <span className="text-zinc-600 dark:text-zinc-400">Converted Amount:</span>
                <span className="text-2xl font-bold text-black dark:text-zinc-50">{result.amount}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-zinc-600 dark:text-zinc-400">Exchange Rate:</span>
                <span className="font-medium text-black dark:text-zinc-50">{result.exchange_rate}</span>
              </div>
              {result.rate_fetched_time && (
                <div className="flex justify-between">
                  <span className="text-sm text-zinc-500 dark:text-zinc-500">Rate Fetched:</span>
                  <span className="text-sm text-zinc-500 dark:text-zinc-500">
                    {new Date(result.rate_fetched_time).toLocaleString()}
                  </span>
                </div>
              )}
            </div>
          </div>
        )}
      </main>
    </div>
  );
}
