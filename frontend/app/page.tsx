export default function Home() {
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
      <main className="flex w-full max-w-2xl flex-col gap-8 px-8 py-16">
        <div className="text-center">
          <h1 className="text-4xl font-bold tracking-tight text-black dark:text-zinc-50">
            Currency Converter
          </h1>
          <p className="mt-2 text-lg text-zinc-600 dark:text-zinc-400">
            Convert between different currencies
          </p>
        </div>

        <form className="flex flex-col gap-6 rounded-lg border border-zinc-200 bg-white p-8 shadow-sm dark:border-zinc-800 dark:bg-zinc-900">
          <div className="flex flex-col gap-2">
            <label htmlFor="from" className="text-sm font-medium text-zinc-700 dark:text-zinc-300">
              From
            </label>
            <select
              id="from"
              name="from"
              className="rounded-md border border-zinc-300 bg-white px-4 py-2 text-base text-zinc-900 focus:border-zinc-500 focus:outline-none focus:ring-2 focus:ring-zinc-500 dark:border-zinc-700 dark:bg-zinc-800 dark:text-zinc-100"
            >
              {currencies.map((currency) => (
                <option key={currency.code} value={currency.code}>
                  {currency.code} - {currency.name}
                </option>
              ))}
            </select>
          </div>

          <div className="flex flex-col gap-2">
            <label htmlFor="to" className="text-sm font-medium text-zinc-700 dark:text-zinc-300">
              To
            </label>
            <select
              id="to"
              name="to"
              className="rounded-md border border-zinc-300 bg-white px-4 py-2 text-base text-zinc-900 focus:border-zinc-500 focus:outline-none focus:ring-2 focus:ring-zinc-500 dark:border-zinc-700 dark:bg-zinc-800 dark:text-zinc-100"
            >
              {currencies.map((currency) => (
                <option key={currency.code} value={currency.code}>
                  {currency.code} - {currency.name}
                </option>
              ))}
            </select>
          </div>

          <div className="flex flex-col gap-2">
            <label htmlFor="amount" className="text-sm font-medium text-zinc-700 dark:text-zinc-300">
              Amount
            </label>
            <input
              type="number"
              id="amount"
              name="amount"
              placeholder="Enter amount"
              className="rounded-md border border-zinc-300 bg-white px-4 py-2 text-base text-zinc-900 focus:border-zinc-500 focus:outline-none focus:ring-2 focus:ring-zinc-500 dark:border-zinc-700 dark:bg-zinc-800 dark:text-zinc-100"
            />
          </div>

          <button
            type="submit"
            className="mt-4 rounded-md bg-black px-6 py-3 text-base font-medium text-white transition-colors hover:bg-zinc-800 dark:bg-zinc-50 dark:text-black dark:hover:bg-zinc-200"
          >
            Convert
          </button>
        </form>
      </main>
    </div>
  );
}
